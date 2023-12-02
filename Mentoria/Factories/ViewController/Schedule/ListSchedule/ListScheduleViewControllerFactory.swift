//  Created by Alessandro Comparini on 01/12/23.
//

import Foundation

import HomeUI
import HomePresenters

class ListScheduleViewControllerFactory {
    
    static func make() -> ListScheduleViewController {
        
        let listSchedulePresenter = ListSchedulePresenterImpl()
        
        return ListScheduleViewController(listSchedulePresenter: listSchedulePresenter)
        
    }
    
}
