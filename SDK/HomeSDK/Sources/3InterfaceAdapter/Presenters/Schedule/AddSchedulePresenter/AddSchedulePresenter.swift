//  Created by Alessandro Comparini on 05/12/23.
//

import Foundation


public protocol AddSchedulePresenter {
    
    func getMonthName(_ date: Date?) -> String
    
    func getWeekName(_ date: Date) -> String
    
    func numberOfItemsDock(dockID: AddSchedulePresenterImpl.DockID) -> Int
    
    func sizeOfItemsDock(dockID: AddSchedulePresenterImpl.DockID) -> CGSize
    
}
