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
import ProfileLocalStorage
import LocalStorageDetails

class SignUpViewControllerFactory {

    static func make() -> SignUpViewController {
        
        let authentication = FirebaseEmailPasswordAuthentication()
        
        let createLoginUseCaseGateway = EmailPasswordCreateLoginUseCaseGatewayImpl(authenticator: authentication)
        
        let createLoginUseCase = CreateLoginUseCaseImpl(createLoginUseCaseGateway: createLoginUseCaseGateway)
        
        let passwordComplexityRulesUseCase = PasswordComplexityRulesUseCaseImpl()
        
        let validation = Validations()
        
        let keyChainProviderStrategy = KeyChainProvider(appName: "MentoriaCodandoComMoa")
        
        let localStorage = ProfileLocalStorage(storageProvider: keyChainProviderStrategy)
        
        let delKeyChainEmailUseCaseGateway = DeleteKeyChainRememberEmailUseCaseGatewayImpl(localStorageKeyChainProvider: localStorage)
        
        let delKeyChainEmailUseCase = DeleteKeyChainRememberEmailUseCaseImpl(delRememberEmailGateway: delKeyChainEmailUseCaseGateway)
        
        let signUpPresenter = SignUpPresenterImpl(createLoginUseCase: createLoginUseCase,
                                                  passwordComplexityRulesUseCase: passwordComplexityRulesUseCase,
                                                  passwordComplexityValidator: validation,
                                                  emailValidator: validation, 
                                                  delKeyChainEmailUseCase: delKeyChainEmailUseCase)
        
        return SignUpViewController(signUpPresenter: signUpPresenter)
    }

}
