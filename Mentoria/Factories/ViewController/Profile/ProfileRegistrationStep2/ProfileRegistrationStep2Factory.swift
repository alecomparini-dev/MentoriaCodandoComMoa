//  Created by Alessandro Comparini on 14/10/23.
//

import Foundation
import ProfileUI
import ProfilePresenters
import ProfileUseCases
import ProfileUseCaseGateway
import ProfileNetwork


class ProfileRegistrationStep2Factory {
    
    static func make() -> ProfileRegistrationStep2ViewController {
        
        let httpGet: HTTPGet = Network()
        
        let url = URL(string: Environment.variable(Environment.Variables.apiBaseCEP))!
        
        let searchUseCaseGateway = RemoteSearchCEPUseCaseGatewayImpl(httpGet: httpGet,
                                                               url: url ,
                                                               headers: [:],
                                                               queryParameters: [:])
        
        let searchUseCase = SearchCEPUseCaseImpl(searchCEPGateway: searchUseCaseGateway)
        
        let profileRegistrationStep2Presenter = ProfileRegistrationStep2PresenterImpl(searchCEPUseCase: searchUseCase)
        
        return ProfileRegistrationStep2ViewController(profileStep2Presenter: profileRegistrationStep2Presenter)
        
    }
    
}
