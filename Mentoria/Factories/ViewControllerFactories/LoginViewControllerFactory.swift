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

    static func make() -> LoginViewController {
        
        let authentication = FirebaseEmailPasswordAuthentication()
        
        let authUseCaseGateway = EmailPasswordAuthenticateUseCaseGatewayImpl(authentication: authentication)
        
        let authUseCase = AuthenticateUseCaseImpl(authUseCaseGateway: authUseCaseGateway)
        
        let loginPresenter = LoginPresenterImpl(validations: [], authUseCase: authUseCase )
        return LoginViewController(loginPresenter: loginPresenter)
    }
    
}
