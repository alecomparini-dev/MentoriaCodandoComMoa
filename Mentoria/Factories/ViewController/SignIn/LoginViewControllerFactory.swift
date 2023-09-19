//
//  LoginViewControllerFactory.swift
//  Mentoria
//
//  Created by Alessandro Comparini on 14/09/23.
//

import Foundation
import ProfileUI
import ProfilePresenters
import ProfileUseCases
import ProfileUseCaseGateway
import ProfileAuthentication

class LoginViewControllerFactory {

    static func make() -> SignInViewController {
        
        let authentication = FirebaseEmailPasswordAuthentication()
        
        let authUseCaseGateway = EmailPasswordAuthenticateUseCaseGatewayImpl(authentication: authentication)
        
        let authUseCase = AuthenticateUseCaseImpl(authUseCaseGateway: authUseCaseGateway)
        
        let signInPresenter = SignInPresenterImpl(authUseCase: authUseCase )
        
        return SignInViewController(signInPresenter: signInPresenter)
    }
    
}
