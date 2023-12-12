//  Created by Alessandro Comparini on 01/12/23.
//

import Foundation

import HomeUseCases

public protocol ListSchedulePresenterOutput: AnyObject {
    func successFetchSchedule()
}


public class ListSchedulePresenterImpl: ListSchedulePresenter {
    public weak var outputDelegate: ListSchedulePresenterOutput?
    
    public enum ItemsFilterDock: Int {
        case currentMonth = 0
        case today = 1
        case sevenDay = 2
        case all = 3
    }
    
    private var scheduleShowList: [String: [[String]]] = [:]
    private var sections: [SectionSchedules] = []
    private var schedulePresenterDTO: [SchedulePresenterDTO] = []
    
    
//  MARK: - INITIALIZERS
    
    private let listScheduleUseCase: ListScheduleUseCase
    
    public init(listScheduleUseCase: ListScheduleUseCase) {
        self.listScheduleUseCase = listScheduleUseCase
    }
    
    
//  MARK: - PUBLIC AREA
    
    private func getDate(_ date: String) -> String {
        let dateSeparated = DateHandler.separateDate(date)
        return "\(dateSeparated.day) / \(DateHandler.getMonthName(dateSeparated.month).prefix(3))"
    }
    
    private func getHours(_ date: String) -> (hour: String, min: String) {
        let dateSeparated = DateHandler.separateDate(date)
        guard let hours = dateSeparated.hours, let min = dateSeparated.min else { return ("","") }
        return (hour: hours.description, min: min.description)
    }
    
    public func fetchSchedule() {
        Task {
            do {
                let schedules = try await listScheduleUseCase.list()
                
                schedulePresenterDTO = schedules.map({ schedule in
                    let hours = getHours("\(schedule.dateInitialSchedule ?? Date())")
                    return SchedulePresenterDTO(
                        id: schedule.id?.uuidString,
                        date: getDate("\(schedule.dateInitialSchedule ?? Date())"),
                        hour: hours.hour,
                        min: hours.min,
                        service: ScheduleServicePresenterDTO(
                            id: schedule.serviceID,
                            name: schedule.serviceName),
                        client: ScheduleClientPresenterDTO(
                            id: schedule.clientID,
                            name: schedule.clientName,
                            address: schedule.address)
                    )
                })
                
                calculateSectionAndRows()
                
                successFetchSchedule()
                                
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    private func calculateSectionAndRows() {
        scheduleShowList = [:]
        for schedule in schedulePresenterDTO {
            guard let date = schedule.date, let hour = schedule.hour, let min = schedule.min else {return}
            if var hours = scheduleShowList[date] {
                hours.append([hour, min])
                scheduleShowList[date] = hours
            } else {
                scheduleShowList[date] = [[hour, min]]
            }
        }
        sections = []
        schedulePresenterDTO.enumerated().forEach { index, schedule in
            guard let date = schedule.date else { return }
            if let indexSection = sections.firstIndex(where: { $0.title == date }){
                sections[indexSection].rows?.append(RowsSchedules(schedule: schedule))
            } else {
                let section = SectionSchedules(title: date, rows: [RowsSchedules(schedule: schedule)])
                sections.append(section)
            }
        }
    }
    
    public func numberOfSectionsSchedule() -> Int {
        return sections.count
    }
    
    public func numberOfRowsSchedule(_ section: Int) -> Int {
        return sections[section].rows?.count ?? 0
    }
    
    public func numberOfItemsFilterDock() -> Int { sizeItemsFilterDock().count }
    
    public func sizeItemsFilterDock() -> [ItemsFilterDock : CGSize] {
        return [
            ItemsFilterDock.currentMonth: CGSize(width: 150, height: 40),
            ItemsFilterDock.today: CGSize(width: 100, height: 40),
            ItemsFilterDock.sevenDay: CGSize(width: 100, height: 40),
            ItemsFilterDock.all: CGSize(width: 135, height: 40),
        ]
    }
    
    public func labelItemsFilterDock() -> [ItemsFilterDock : String] {
        return [
            ItemsFilterDock.currentMonth: "Mês atual",
            ItemsFilterDock.today: "Hoje",
            ItemsFilterDock.sevenDay: "7 dias",
            ItemsFilterDock.all: "Ver todos",
        ]
    }
    
    public func iconItemsFilterDock() -> [ItemsFilterDock: String] {
        return [
            ItemsFilterDock.currentMonth: "calendar.badge.clock",
            ItemsFilterDock.today: "target",
            ItemsFilterDock.sevenDay: "calendar.circle",
            ItemsFilterDock.all: "rectangle.stack",
        ]
    }
    
    
//  MARK: - MAIN THREAD AREA
    private func successFetchSchedule() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            outputDelegate?.successFetchSchedule()
        }
    }
                            
    
}



