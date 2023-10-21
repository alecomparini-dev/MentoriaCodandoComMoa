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
        
        
        let httpPost: HTTPPost = Network()
        let baseURL = URL(string: Environment.variable(Environment.Variables.apiBaseUrl))!
        
        let createProfileUseCaseGateway = RemoteCreateProfileUseCaseGatewayImpl(
            httpPost: httpPost,
            url: baseURL,
            headers: [:],
            queryParameters: [:])
        
        let createProfileUseCase = CreateProfileUseCaseImpl(createProfileUseCaseGateway: createProfileUseCaseGateway)
        
        let profileRegistrationStep2Presenter = ProfileRegistrationStep2PresenterImpl(createProfile: createProfileUseCase, searchCEPUseCase: searchUseCase, cepMask: CEPMask())
        
        return ProfileRegistrationStep2ViewController(profileStep2Presenter: profileRegistrationStep2Presenter)
        
    }
    
    
}
