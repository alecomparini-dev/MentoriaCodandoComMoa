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
import ProfileValidations

class SignUpViewControllerFactory {

    static func make() -> SignUpViewController {
        
        let authentication = FirebaseEmailPasswordAuthentication()
        
        let createLoginUseCaseGateway = EmailPasswordCreateLoginUseCaseGatewayImpl(authentication: authentication)
        
        let createLoginUseCase = CreateLoginUseCaseImpl(createLoginUseCaseGateway: createLoginUseCaseGateway)
        
        let passwordComplexityRulesUseCase = PasswordComplexityRulesUseCaseImpl()
        
        let validation = Validations()
        
        let signUpPresenter = SignUpPresenterImpl(createLoginUseCase: createLoginUseCase,
                                                  passwordComplexityRulesUseCase: passwordComplexityRulesUseCase,
                                                  passwordComplexityValidator: validation,
                                                  emailValidator: validation)
        
        return SignUpViewController(signUpPresenter: signUpPresenter)
    }

}
