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
                    SchedulePresenterDTO(
                        id: schedule.id?.uuidString,
                        date: getDate("\(schedule.dateInitialSchedule ?? Date())"),
                        hour: getHours("\(schedule.dateInitialSchedule ?? Date())").hour,
                        min: getHours("\(schedule.dateInitialSchedule ?? Date())").min,
                        service: ScheduleServicePresenterDTO(
                            id: schedule.serviceID,
                            name: schedule.serviceName),
                        client: ScheduleClientPresenterDTO(
                            id: schedule.clientID,
                            name: schedule.clientName,
                            address: schedule.address)
                    )
                })
                
                print(schedulePresenterDTO)
                
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    public func numberOfSectionsSchedule() -> Int {
        return 3
    }
    
    public func numberOfRowsSchedule(_ section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return 10
        default:
            return 0
        }
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
                            
    
}


//
//        do {
//            let jsonData = jsonData.data(using: .utf8)!
//
//            let events = try JSONDecoder().decode([Event].self, from: jsonData)
//
//            var hoursByDate: [String: Set<String>] = [:]
//
//            for event in events {
//                if var hours = hoursByDate[event.data] {
//                    hours.insert(event.hora)
//                    hoursByDate[event.data] = hours
//                } else {
//                    hoursByDate[event.data] = [event.hora]
//                }
//            }
//        } catch {
//            print("Erro ao decodificar JSON: \(error)")
//        }
