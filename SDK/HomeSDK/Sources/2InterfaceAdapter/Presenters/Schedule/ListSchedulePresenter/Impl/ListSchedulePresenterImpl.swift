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
    
    private var sections: [SectionSchedules] = []
    private var schedulePresenterDTO: [SchedulePresenterDTO] = []
    
    
//  MARK: - INITIALIZERS
    
    private let listScheduleUseCase: ListScheduleUseCase
    
    public init(listScheduleUseCase: ListScheduleUseCase) {
        self.listScheduleUseCase = listScheduleUseCase
    }
    
    
//  MARK: - PUBLIC AREA
    private func saveOnlyDate(_ date: String?) -> String {
        guard let date else { return "" }
        let separetedDate = DateHandler.separateDate(date)
        return "\(separetedDate.year)-\(separetedDate.month)-\(separetedDate.day)"
    }
    
    public func fetchSchedule() {
        Task {
            do {
                let schedules = try await listScheduleUseCase.list()
                
                schedulePresenterDTO = schedules.map({ schedule in
                    let hours = getHours("\(schedule.dateInitialSchedule ?? Date())")
                    return SchedulePresenterDTO(
                        id: schedule.id?.uuidString,
                        date: saveOnlyDate(schedule.dateInitialSchedule?.description),
                        hour: String(format: "%02d", Int(hours.hour) ?? ""),
                        min: String(format: "%02d", Int(hours.min) ?? ""),
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
    
    public func getSectionSchedule(_ section: Int) -> SectionSchedules {
        return sections[section]
    }
    
    public func getRowSchedule(_ section: Int, _ row: Int) -> SchedulePresenterDTO {
        return sections[section].rows[row].schedule ?? SchedulePresenterDTO()
    }
    
    public func numberOfSectionsSchedule() -> Int {
        return sections.count
    }
    
    public func numberOfRowsSchedule(_ section: Int) -> Int {
        return sections[section].rows.count
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
    
    
    
//  MARK: - PRIVATE AREA
    
    private func getHours(_ date: String) -> (hour: String, min: String) {
        let dateSeparated = DateHandler.separateDate(date)
        guard let hours = dateSeparated.hours, let min = dateSeparated.min else { return ("","") }
        return (hour: hours.description, min: min.description)
    }
    
    private func calculateSectionAndRows() {
        sections = []
        schedulePresenterDTO.enumerated().forEach { index, schedule in
            guard let date = schedule.date else { return }
            if let indexSection = sections.firstIndex(where: { $0.dateControl == date }){
                sections[indexSection].rows.append(RowsSchedules(schedule: schedule))
            } else {
                let title = makeTitleSection(date)
                let section = SectionSchedules(
                    dateControl: title.dateControl,
                    dayTitle: title.day,
                    monthTitle: title.month,
                    dayWeekNameTitle: title.dayWeekName,
                    rows: [RowsSchedules(schedule: schedule)])
                sections.append(section)
            }
        }
    }
    
    private func makeTitleSection(_ date: String) -> (dateControl: String,  day: String, month: String, dayWeekName: String) {
        let dateSeparated = DateHandler.separateDate(date)
        
        var title: (day: String, month: String, dayWeekName: String)
        
        title.day = "\(dateSeparated.day)"
        
        title.month = "\(DateHandler.getMonthName(dateSeparated.month).prefix(3))"
        
        title.dayWeekName = ""
        
        if let dayWeekInt = DateHandler.dayWeek(date) {
            title.dayWeekName = "\(DateHandler.dayWeekName(dayWeekInt).lowercased())"
        }
        
        let dateControl = "\(dateSeparated.year)-\(dateSeparated.month)-\(title.day)"
        
        return (dateControl: dateControl, day: title.day, month: title.month, dayWeekName: title.dayWeekName)
    }
    
    
//  MARK: - MAIN THREAD AREA
    private func successFetchSchedule() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            outputDelegate?.successFetchSchedule()
        }
    }
                            
    
}



