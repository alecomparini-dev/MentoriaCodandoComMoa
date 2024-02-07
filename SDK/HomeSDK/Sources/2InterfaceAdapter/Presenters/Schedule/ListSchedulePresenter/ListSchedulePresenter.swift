//  Created by Alessandro Comparini on 01/12/23.
//

import Foundation

public protocol ListSchedulePresenter {
    var outputDelegate: ListSchedulePresenterOutput? { get set }
    
    func fetchSchedule()
    func getSectionSchedule(_ section: Int) -> SectionSchedules
    func getRowSchedule(_ section: Int, _ row: Int) -> SchedulePresenterDTO
    
    func numberOfSectionsSchedule() -> Int
    func numberOfRowsSchedule(_ section: Int) -> Int

    func numberOfItemsFilterDock() -> Int
    func sizeItemsFilterDock() -> [ListSchedulePresenterImpl.ItemsFilterDock: CGSize]
    func labelItemsFilterDock() -> [ListSchedulePresenterImpl.ItemsFilterDock: String]
    func iconItemsFilterDock() -> [ListSchedulePresenterImpl.ItemsFilterDock: String]
    
}
