//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation

import ProfileUI
import ProfilePresenters
import ProfileUseCases
import ProfileUseCaseGateway
import ProfileAuthentication

class ProfileSummaryViewControllerFactory {

    static func make() -> ProfileSummaryViewController {
        
        let masks: [TypeMasks: Masks] = MasksFactory.make()
        
        let network = Network()
        
        let url = makeURL()
        
        let getProfileUseCaseGateway = RemoteGetProfileUseCaseGatewayImpl(httpGet: network, url: url, headers: [:], queryParameters: [:])
        
        let getProfileUseCase = GetProfileUseCaseImpl(getProfileUseCaseGateway: getProfileUseCaseGateway )
        
        let userAutenticator = FirebaseUserAuthenticated()
        
        let getUserAuthUseCaseGateway = GetUserAuthenticatedUseCaseGatewayImpl(userAuthenticator: userAutenticator)
        
        let getUserAuthUseCase = GetUserAuthenticatedUseCaseImpl(getUserAuthenticatedGateway: getUserAuthUseCaseGateway)
        
        let createProfileUseCase = CreateProfileUseCaseFactory.make()
        
        let profileSummaryPresenter = ProfileSummaryPresenterImpl(getUserAuthUseCase: getUserAuthUseCase, getProfileUseCase: getProfileUseCase, createProfile: createProfileUseCase, masks: masks)
        
        return ProfileSummaryViewController(profileSummaryPresenter: profileSummaryPresenter)
        
    }
    
    static private func makeURL() -> URL {
        let baseURL = Environment.variable(.apiBaseUrl)
        let path = K.pathGetListProfile
        return URL(string: "\(baseURL)\(path)")!
    }
    
    
}

