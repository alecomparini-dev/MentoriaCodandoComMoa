//
//  SignUpViewControllerFactory.swift
//  Mentoria
//
//  Created by Alessandro Comparini on 15/09/23.
//

import Foundation
import ProfileAuthentication
import ProfilePresenters
import ProfileUI
import ProfileUseCases
import ProfileUseCaseGateway
import ProfileValidators

class SignUpViewControllerFactory {

    static func make() -> SignUpViewController {
        
        let authentication = FirebaseEmailPasswordAuthentication()
        
        let createLoginUseCaseGateway = EmailPasswordCreateLoginUseCaseGatewayImpl(authentication: authentication)
        
        let createLoginUseCase = CreateLoginUseCaseImpl(createLoginUseCaseGateway: createLoginUseCaseGateway)
        
        let passwordComplexityRulesUseCase = PasswordComplexityRulesUseCaseImpl()
        
        let passwordValidator = Validators()
        
        let signUpPresenter = SignUpPresenterImpl(createLoginUseCase: createLoginUseCase, passwordComplexityRulesUseCase: passwordComplexityRulesUseCase, passwordComplexityValidator: passwordValidator )
        
        return SignUpViewController(signUpPresenter: signUpPresenter)
    }

}
