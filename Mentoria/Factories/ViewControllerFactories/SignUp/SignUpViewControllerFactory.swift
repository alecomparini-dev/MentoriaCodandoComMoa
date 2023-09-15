//
//  SignUpViewControllerFactory.swift
//  Mentoria
//
//  Created by Alessandro Comparini on 15/09/23.
//

import Foundation
import ProfileUI
import ProfilePresenters
import ProfileUseCases
import ProfileUseCaseGateway
import ProfileAuthentication


class SignUpViewControllerFactory {

static func make() -> SignUpViewController {
    
    let authentication = FirebaseEmailPasswordAuthentication()
    
    let createLoginUseCaseGateway = EmailPasswordCreateLoginUseCaseGatewayImpl(authentication: authentication)
    
    let createLoginUseCase = CreateLoginUseCaseImpl(createLoginUseCaseGateway: createLoginUseCaseGateway)
    
    let signUpPresenter = SignUpPresenterImpl(validations: [], createLoginUseCase: createLoginUseCase )
    
    return SignUpViewController(signUpPresenter: signUpPresenter)
}

}
