//  Created by Alessandro Comparini on 27/10/23.
//

import UIKit

import HomeUI
import HomePresenters
import HomeUseCases
import HomeUseCaseGateway
import HomeNetwork

class ViewerServiceViewControllerFactory: UIViewController {
    
    static func make() -> ViewerServiceViewController {
        
        let httpPost = HomeNetwork()
        
        let url = makeURL()
        
        let disableServiceUseCaseGateway = RemoteDisableServiceUseCaseGatewayImpl(httpPost: httpPost, url: url, headers: [:], queryParameters: [:])
        
        let disableServiceUseCase = DisableServiceUseCaseImpl(disableServiceUseCaseGateway: disableServiceUseCaseGateway)
        
        let viewerServicePresenter = ViewerServicePresenterImpl(disableServiceUseCase: disableServiceUseCase)
        
        return ViewerServiceViewController(viewerServicePresenter: viewerServicePresenter)
    }
    
    static private func makeURL() -> URL {
        let baseURL = Environment.variable(.apiBaseUrl)
        let path = K.pathDisableService
        return URL(string: "\(baseURL)\(path)")!
    }
    
}
