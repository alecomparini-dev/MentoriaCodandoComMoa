//  Created by Alessandro Comparini on 26/10/23.
//

import Foundation

import HomeUI
import HomePresenters

class ListServicesViewControllerFactory {
    
    static func make() -> ListServicesViewController {
        
        let listServicePresenter = ListServicesPresenterImpl()
        
        return ListServicesViewController(listServicePresenter: listServicePresenter)
        
    }
    
}
