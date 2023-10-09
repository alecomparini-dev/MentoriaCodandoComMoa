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
import ProfileLocalStorage
import ProfileValidations
import LocalStorageSDKMain
import LocalStorageDetails


class LoginViewControllerFactory {

    static func make() -> SignInViewController {
        
        let authentication = FirebaseEmailPasswordAuthentication()
        
        let authUseCaseGateway = EmailPasswordAuthenticateUseCaseGatewayImpl(authentication: authentication)
        
        let authUseCase = AuthenticateUseCaseImpl(authUseCaseGateway: authUseCaseGateway)
        
        let keyChainProviderStrategy = KeyChainProvider(appName: "MentoriaCodandoComMoa", forKey: "email")
//        let keyChainProviderStrategy = UserDefaultsProvider(forKey: "email")
        
        let localStorage = LocalStorage(storageProvider: keyChainProviderStrategy)
        
        let saveKeyChainGateway = SaveKeyChainUseCaseGatewayImpl(localStorageKeyChainProvider: localStorage)
        
        let saveKeyChainEmailUseCase = SaveKeyChainRememberEmailUseCaseImpl(saveKeyChainGateway: saveKeyChainGateway)
        
        let getKeyChainEmailUseCaseGateway = GetKeyChainRememberEmailUseCaseGatewayImpl(localStorageKeyChainProvider: localStorage)
        
        let getKeyChainEmailUseCase = GetKeyChainRememberEmailUseCaseImpl(getRememberEmailGateway: getKeyChainEmailUseCaseGateway)
        
        let delKeyChainEmailUseCaseGateway = DeleteKeyChainRememberEmailUseCaseGatewayImpl(localStorageKeyChainProvider: localStorage)
        
        let delKeyChainEmailUseCase = DeleteKeyChainRememberEmailUseCaseImpl(delRememberEmailGateway: delKeyChainEmailUseCaseGateway)
        
        let validation = Validations()
        
        let signInPresenter = SignInPresenterImpl(authUseCase: authUseCase,
                                                  saveKeyChainEmailUseCase: saveKeyChainEmailUseCase, 
                                                  getKeyChainEmailUseCase: getKeyChainEmailUseCase, 
                                                  delKeyChainEmailUseCase: delKeyChainEmailUseCase, 
                                                  emailValidator: validation )
        
        return SignInViewController(signInPresenter: signInPresenter)
    }
    
}
