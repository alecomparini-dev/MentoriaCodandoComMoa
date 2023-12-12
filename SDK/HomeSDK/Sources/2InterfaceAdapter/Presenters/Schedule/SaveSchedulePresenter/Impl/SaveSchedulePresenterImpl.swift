//  Created by Alessandro Comparini on 05/12/23.
//

import Foundation

import HomeUseCases

public protocol SaveSchedulePresenterOutput: AnyObject {
    func successSaveSchedule()
    func successFetchServiceList()
    func successFetchClientList()
    func resetHours()
}

public class SaveSchedulePresenterImpl: SaveSchedulePresenter {
    public weak var outputDelegate: SaveSchedulePresenterOutput?
    
    private var clientsList: [ClientListPresenterDTO] = []
    private var servicesList: [ServiceListPresenterDTO] = []
    private var daysDock: [DateDockPresenterDTO] = []
    private var hoursDock: [HourDockPresenterDTO] = []
    
    public enum DockID: String {
        case daysDock = "DAYS_DOCK"
        case hoursDock = "HOURS_DOCK"
    }
    
    public enum ListID: String {
        case clients = "CLIENTS"
        case services = "SERVICES"
    }
    
    private let weekend = [1,7]
    
    
//  MARK: - INITIALIZERS
    
    private let listClientsUseCase: ListClientsUseCase
    private let listServicesUseCase: ListServicesUseCase
    private let saveScheduleUseCase: SaveScheduleUseCase
    
    public init(listClientsUseCase: ListClientsUseCase, listServicesUseCase: ListServicesUseCase, saveScheduleUseCase: SaveScheduleUseCase) {
        self.listClientsUseCase = listClientsUseCase
        self.listServicesUseCase = listServicesUseCase
        self.saveScheduleUseCase = saveScheduleUseCase
    }
    
    
//  MARK: - PUBLIC AREA
    
    public func fetchServices(_ userIDAuth: String) {
        Task {
            do {
                let servicesDTO: [ServiceUseCaseDTO]? = try await listServicesUseCase.list(userIDAuth)
                
                guard let servicesDTO else {return}
                
                let servicesList = servicesDTO.map({ service in
                    ServiceListPresenterDTO(
                        id: service.id,
                        name: service.name,
                        duration: service.duration)
                })
                
                self.servicesList.append(contentsOf: servicesList)
                
                successFetchListServices()
                
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    public func fetchClients(_ userIDAuth: String) {
        Task {
            do {
                let clientsDTO: [ClientUseCaseDTO]? = try await listClientsUseCase.list(userIDAuth)
                
                guard let clientsDTO else {return}
                
                let clientList = clientsDTO.map({ client in
                    ClientListPresenterDTO(
                        id: client.id,
                        name: client.name,
                        street: client.street,
                        number: client.number,
                        neighborhood: client.neighborhood,
                        complement: client.complement
                    )
                })
                
                self.clientsList.append(contentsOf: clientList)
                
                successFetchClientList()
                
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    public func saveSchedule(clientID: Int?, serviceID: Int?, dateInitialSchedule: Date?) {
        //validation
        Task {
            
            guard let client = clientsList.first(where: { $0.id == clientID }) else { return }
            guard let service = servicesList.first(where: { $0.id == serviceID }) else { return }
        
            let schedule = ScheduleUseCaseDTO(
                id: UUID(), 
                address: "\(client.street ?? ""), \(client.number ?? "") - \(client.neighborhood ?? "")",
                clientID: client.id,
                clientName: client.name,
                serviceID: service.id,
                serviceName: service.name,
                dateInitialSchedule: dateInitialSchedule,
                dateFinalSchedule: Date())
            
            do {
                try await saveScheduleUseCase.save(schedule)
                successSaveSchedule()
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }

    public func getClient(_ index: Int) -> ClientListPresenterDTO? { clientsList[index] }
    
    public func getService(_ index: Int) -> ServiceListPresenterDTO? { servicesList[index] }
    
    public func fetchDayDock(_ year: Int, _ month: Int) {
        calculateDaysOfMonth(year: year, month: month)
    }
    
    public func fetchHourDock(_ year: Int, _ month: Int, _ day: Int) {
        calculateHoursOfDay()
    }

    public func getDayDock(_ index: Int) -> DateDockPresenterDTO? {
        return daysDock[index]
    }
    
    public func getHourDock(_ index: Int) -> HourDockPresenterDTO? {
        return hoursDock[index]
    }
    
    public func getDayWeekName(_ date: String) -> String? {
        guard let dayWeek = dayWeek(date) else { return nil }
        return dayWeekName(dayWeek)
    }
    
    public func getMonthName(_ date: Date? = nil) -> String {
        let calendar = Calendar.current
        guard let date = (date == nil) ? Date() : date else { return "" }
        let month = calendar.component(.month, from: date)
        return getMonthName(month)
    }
    
    public func getCurrentDate() -> (year: Int, month: Int, day: Int) {
        return DateHandler.getCurrentDate()
    }
    
    public func numberOfRowsList(listID: ListID) -> Int {
        switch listID {
            case .clients:
                return clientsList.count
                
            case .services:
                return servicesList.count
        }
    }
    
    public func numberOfItemsDock(dockID: DockID) -> Int {
        switch dockID {
            case .daysDock:
                return daysDock.count
            
            case .hoursDock:
                return hoursDock.count
        }
    }
    
    public func sizeOfItemsDock(dockID: DockID) -> CGSize {
        switch dockID {
            case .daysDock:
                return CGSize(width: 55, height: 70)
            
            case .hoursDock:
                return CGSize(width: 100, height: 44)
        }
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func getMonthName(_ month: Int) -> String {
        return DateHandler.getMonthName(month)
    }
    
    public func getMonthInt(_ monthPTBR: String) -> Int? {
        return DateHandler.getMonthInt(monthPTBR)
    }
    
    private func dayWeekName(_ dayWeek: Int) -> String {
        return DateHandler.dayWeekName(dayWeek)
    }
    
    private func dayWeek(_ date: String) -> Int? {
        return DateHandler.dayWeek(date)
    }
    
    private func calculateDaysOfMonth(year: Int, month: Int) {
        let calendar = Calendar.current
        
        let componentDate = DateComponents(
            year: year,
            month: month
        )
        
        guard let date = calendar.date(from: componentDate) else { return }
        
        guard let range = calendar.range(of: .day, in: .month, for: date) else { return }
        
        for day in (1...range.count) {
            let dateString = "\(year)/\(month)/\(day)"
            
            guard let dayWeek = dayWeek(dateString) else { return }
            
            daysDock.append(DateDockPresenterDTO(
                day: "\(day)",
                month: "\(month)",
                year: "\(year)",
                dayWeek: "\(dayWeekName(dayWeek).prefix(3).uppercased() )",
                disabled: isDisableDay(day, dayWeek) )
            )
        }   
    }
    
    private func calculateHoursOfDay() {
        let calendar = Calendar.current
        var currentDateComponents = DateComponents()
        currentDateComponents.hour = 8
        currentDateComponents.minute = 0
        
        guard let startDate = calendar.date(from: currentDateComponents) else { return }
        
        let endDate = calendar.date(bySettingHour: 18, minute: 0, second: 0, of: startDate)!
        
        var currentDate = startDate
        let dateHourFormatter = DateFormatter()
        let dateMinuteFormatter = DateFormatter()
        dateHourFormatter.dateFormat = "HH"
        dateMinuteFormatter.dateFormat = "mm"
        
        hoursDock = []
        while currentDate <= endDate {
            let formattedHour = dateHourFormatter.string(from: currentDate)
            let formattedMinute = dateMinuteFormatter.string(from: currentDate)
            currentDate = calendar.date(byAdding: .minute, value: 30, to: currentDate)!
            hoursDock.append(
                HourDockPresenterDTO(
                    hour: formattedHour,
                    minute: formattedMinute,
                    disabled: isDisableHour(formattedHour, formattedMinute) )
            )
        }
        
        outputDelegate?.resetHours()
    }
    
    private func isDisableHour(_ hour: String, _ min: String) -> Bool {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "HH:mm"
        
        guard
            let hourCompare = formatter.date(from: "\(hour):\(min)"),
            let lunch1 = formatter.date(from: "12:00"),
            let lunch2 = formatter.date(from: "14:00") else { return false }
        
        return hourCompare >= lunch1 && hourCompare <= lunch2
    }
    
    private func isDisableDay(_ day: Int, _ dayWeek: Int) -> Bool {
        let calendar = Calendar.current
        let currentDay = calendar.component(.day, from: Date())
        return day < currentDay || weekend.contains(dayWeek)
    }
    
    
    
//  MARK: - MAIN THREAD AREA
    
    private func successFetchListServices() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            outputDelegate?.successFetchServiceList()
        }
    }
    
    private func successFetchClientList() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            outputDelegate?.successFetchClientList()
        }
    }    
    
    private func successSaveSchedule() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            outputDelegate?.successSaveSchedule()
        }
    }

}
