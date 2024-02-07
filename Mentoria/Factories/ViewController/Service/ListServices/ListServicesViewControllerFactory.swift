//  Created by Alessandro Comparini on 26/10/23.
//

import Foundation

import HomeUI
import HomePresenters
import HomeUseCases
import HomeUseCaseGateway
import HomeNetwork


class ListServicesViewControllerFactory {
    
    static func make() -> ListServicesViewController {
        
        let listServicesUseCase = ListServicesUseCaseFactory.make()
        
        let listServicePresenter = ListServicesPresenterImpl(listServicesUseCase: listServicesUseCase )
        
        return ListServicesViewController(listServicePresenter: listServicePresenter)
        
    }
    
    
    
    
}
