//  Created by Alessandro Comparini on 01/12/23.
//

import Foundation

import HomeUseCases

public class ListSchedulePresenterImpl: ListSchedulePresenter {
    
    private let listScheduleUseCase: ListScheduleUseCase
    
    public init(listScheduleUseCase: ListScheduleUseCase) {
        self.listScheduleUseCase = listScheduleUseCase
    }
    
    
//  MARK: - PUBLIC AREA
    
    public func fetchSchedule() {
        Task {
            do {
                let schedules = try await listScheduleUseCase.list()
                print(schedules)
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
        
    }
    
    public enum ItemsFilterDock: Int {
        case currentMonth = 0
        case today = 1
        case sevenDay = 2
        case all = 3
    }
    
    public func numberOfItemsListSchedule() -> Int {
        return 3
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
