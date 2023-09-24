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
        
        let saveKeyChainEmailUseCaseGateway = SaveKeyChainRememberEmailUseCaseGatewayImpl(localStorageKeyChainProvider: localStorage)
        
        let saveKeyChainEmailUseCase = SaveKeyChainRememberEmailUseCaseImpl(saveRememberEmailGateway: saveKeyChainEmailUseCaseGateway)
        
        let getKeyChainEmailUseCaseGateway = GetKeyChainRememberEmailUseCaseGatewayImpl(localStorageKeyChainProvider: localStorage)
        
        let getKeyChainEmailUseCase = GetKeyChainRememberEmailUseCaseImpl(getRememberEmailGateway: getKeyChainEmailUseCaseGateway)
        
        let delKeyChainEmailUseCaseGateway = DeleteKeyChainRememberEmailUseCaseGatewayImpl(localStorageKeyChainProvider: localStorage)
        
        let delKeyChainEmailUseCase = DeleteKeyChainRememberEmailUseCaseImpl(delRememberEmailGateway: delKeyChainEmailUseCaseGateway)
        
        let signInPresenter = SignInPresenterImpl(authUseCase: authUseCase,
                                                  saveKeyChainEmailUseCase: saveKeyChainEmailUseCase, 
                                                  getKeyChainEmailUseCase: getKeyChainEmailUseCase, 
                                                  delKeyChainEmailUseCase: delKeyChainEmailUseCase )
        
        return SignInViewController(signInPresenter: signInPresenter)
    }
    
}
