//  Created by Alessandro Comparini on 05/12/23.
//

import Foundation

import HomeUI
import HomePresenters

class AddScheduleViewControllerFactory {
    
    static func make() -> AddScheduleViewController {
        
        let addSchedulePresenter = AddSchedulePresenterImpl()
        
        return AddScheduleViewController(addSchedulePresenter: addSchedulePresenter)
        
    }
    
}
