//  Created by Alessandro Comparini on 28/10/23.
//

import UIKit

import HomeUI
import HomePresenters
import HomeUseCases
import HomeUseCaseGateway
import HomeNetwork

class AddServiceViewControllerFactory {
    static func make() -> AddServiceViewController {
        
        let httpPost = HomeNetwork()
        
        let url = makeURL()
        
        let addServiceUseCaseGateway = RemoteAddServiceUseCaseGatewayImpl(
            httpPost: httpPost, url: url, headers: [:], queryParameters: [:])
        
        let addServiceUseCase = AddServiceUseCaseImpl(addServiceUseCaseGateway: addServiceUseCaseGateway)
        
        let addServicePresenter = AddServicePresenterImpl(addServiceUseCase: addServiceUseCase)
        
        return AddServiceViewController(addServicePresenter: addServicePresenter)
        
    }
    
    static private func makeURL() -> URL {
        let baseURL = Environment.variable(.apiBaseUrl)
        let path = K.pathPostService
        return URL(string: "\(baseURL)\(path)")!
    }
}
