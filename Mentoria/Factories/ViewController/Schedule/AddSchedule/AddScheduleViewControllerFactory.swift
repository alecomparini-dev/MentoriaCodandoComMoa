//  Created by Alessandro Comparini on 05/12/23.
//

import Foundation

import HomeUI
import HomePresenters
import HomeUseCases
import HomeUseCaseGateway
import HomeNetwork

class AddScheduleViewControllerFactory {
    
    static func make() -> AddScheduleViewController {
        
        let listServicesUseCase = ListServicesUseCaseFactory.make()
        
        let addSchedulePresenter = AddSchedulePresenterImpl(listServicesUseCase: listServicesUseCase)
        
        return AddScheduleViewController(addSchedulePresenter: addSchedulePresenter)
        
    }
    
}
