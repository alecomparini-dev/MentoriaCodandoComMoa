//  Created by Alessandro Comparini on 01/12/23.
//

import Foundation

public protocol ListSchedulePresenter {
    
    func numberOfItemsListSchedule() -> Int
    func numberOfItemsFilterDock() -> Int
    
    func sizeItemsFilterDock() -> [ListSchedulePresenterImpl.ItemsFilterDock: CGSize]
    func labelItemsFilterDock() -> [ListSchedulePresenterImpl.ItemsFilterDock: String]
    func iconItemsFilterDock() -> [ListSchedulePresenterImpl.ItemsFilterDock: String]
    
}
