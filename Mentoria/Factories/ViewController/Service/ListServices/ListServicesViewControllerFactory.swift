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
        
        let httpGet = HomeNetwork()
        
        let url = makeURL()
        
        let listServicesUseCaseGateway = RemoteListServicesUseCaseGatewayImpl(httpGet: httpGet ,
                                                                              url: url, headers: [:],
                                                                              queryParameters: [:])
        
        let listServicesUseCase = ListServicesUseCaseImpl(listServicesGateway: listServicesUseCaseGateway)
        
        let listServicePresenter = ListServicesPresenterImpl(listServicesUseCase: listServicesUseCase )
        
        return ListServicesViewController(listServicePresenter: listServicePresenter)
        
    }
    
    
    static private func makeURL() -> URL {
        let baseURL = Environment.variable(.apiBaseUrl)
        let path = K.pathListServices
        return URL(string: "\(baseURL)\(path)")!
    }
    
}
