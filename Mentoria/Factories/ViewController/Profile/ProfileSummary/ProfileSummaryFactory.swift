//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation

import ProfileUI
import ProfilePresenters
import ProfileUseCases
import ProfileUseCaseGateway
import ProfileAuthentication

class ProfileSummaryFactory {

    static func make() -> ProfileSummaryViewController {
        
        let userAutenticator = FirebaseUserAuthenticated()
        
        let getUserAuthUseCaseGateway = GetUserAuthenticatedUseCaseGatewayImpl(userAuthenticator: userAutenticator)
        
        let getUserAuthUseCase = GetUserAuthenticatedUseCaseImpl(getUserAuthenticatedGateway: getUserAuthUseCaseGateway)
        
        let profileSummaryPresenter = ProfileSummaryPresenterImpl(getUserAuthUseCase: getUserAuthUseCase)
        
        return ProfileSummaryViewController(profileSummaryPresenter: profileSummaryPresenter)
        
    }
    
}
