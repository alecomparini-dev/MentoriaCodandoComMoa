//  Created by Alessandro Comparini on 28/10/23.
//

import UIKit

import HomeUI
import HomePresenters
import HomeUseCases
import HomeUseCaseGateway
import HomeNetwork

class AddServiceViewControllerFactory {
    static func make() -> SaveServiceViewController {
        
        let httpPost = HomeNetwork()
        
        let saveServiceUseCaseGateway = RemoteSaveServiceUseCaseGatewayImpl(
            httpPost: httpPost, url: makeURL(K.pathPostService), headers: [:], queryParameters: [:])
        
        let saveServiceUseCase = SaveServiceUseCaseImpl(saveServiceUseCaseGateway: saveServiceUseCaseGateway)
        
        let disableServiceUseCaseGateway = RemoteDisableServiceUseCaseGatewayImpl(
            httpPost: httpPost, url: makeURL(K.pathDisableService), headers: [:], queryParameters: [:])
        
        let disableServiceUseCase = DisableServiceUseCaseImpl(disableServiceUseCaseGateway: disableServiceUseCaseGateway)
        
        let saveServicePresenter = SaveServicePresenterImpl(saveServiceUseCase: saveServiceUseCase,
                                                           disableServiceUseCase: disableServiceUseCase)
        
        return SaveServiceViewController(saveServicePresenter: saveServicePresenter)
        
    }
    
    static private func makeURL(_ path: String) -> URL {
        let baseURL = Environment.variable(.apiBaseUrl)
        return URL(string: "\(baseURL)\(path)")!
    }
}
