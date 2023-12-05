//  Created by Alessandro Comparini on 05/12/23.
//

import Foundation


public protocol AddSchedulePresenter {
    
    
    func getCurrentMonth() -> String
    
    func numberOfItemsDock(dockID: AddSchedulePresenterImpl.DockID) -> Int
    
    func sizeOfItemsDock(dockID: AddSchedulePresenterImpl.DockID) -> CGSize
    
}
