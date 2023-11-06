//
//  LoginViewControllerFactory.swift
//  Mentoria
//
//  Created by Alessandro Comparini on 14/09/23.
//

import Foundation
import LocalAuthentication
import LocalStorageDetails
import ProfileAuthentication
import ProfileLocalStorage
import ProfilePresenters
import ProfileUI
import ProfileUseCases
import ProfileUseCaseGateway
import ProfileValidations


class LoginViewControllerFactory {

    static func make() -> SignInViewController {
        
        let authentication = FirebaseEmailPasswordAuthentication()
        
        let authUseCaseGateway = EmailPasswordAuthenticateUseCaseGatewayImpl(authentication: authentication)
        let authUseCase = AuthenticateUseCaseImpl(authUseCaseGateway: authUseCaseGateway)
        
        let keyChainProviderStrategy = KeyChainProvider(appName: K.Strings.appName)
        
        let localStorage = ProfileLocalStorage(storageProvider: keyChainProviderStrategy)
        
        let saveKeyChainGateway = SaveKeyChainUseCaseGatewayImpl(localStorageKeyChainProvider: localStorage)
        let saveKeyChainEmailUseCase = SaveKeyChainRememberEmailUseCaseImpl(saveKeyChainGateway: saveKeyChainGateway)
        
        let getKeyChainEmailUseCaseGateway = GetKeyChainUseCaseGatewayImpl(localStorageKeyChainProvider: localStorage)
        let getKeyChainEmailUseCase = GetKeyChainRememberEmailUseCaseImpl(getRememberEmailGateway: getKeyChainEmailUseCaseGateway)
        
        let delKeyChainEmailUseCaseGateway = DeleteKeyChainUseCaseGatewayImpl(localStorageKeyChainProvider: localStorage)
        let delKeyChainEmailUseCase = DeleteKeyChainRememberEmailUseCaseImpl(delRememberEmailGateway: delKeyChainEmailUseCaseGateway)
        
        let biometryAuthentication = LocalAuthentication()
        let checkBiometryGateway = CheckBiometryUseCaseGatewayImpl(biometryAuthentication: biometryAuthentication)
        let checkBiometryUseCase = CheckBiometryUseCaseImpl(checkBiometryGateway: checkBiometryGateway)
        
        let validation = Validations()
        
        let signInPresenter = SignInPresenterImpl(authUseCase: authUseCase,
                                                  saveKeyChainEmailUseCase: saveKeyChainEmailUseCase, 
                                                  getKeyChainEmailUseCase: getKeyChainEmailUseCase, 
                                                  delKeyChainEmailUseCase: delKeyChainEmailUseCase, 
                                                  checkBiometryUseCase: checkBiometryUseCase,
                                                  emailValidator: validation )
        
        return SignInViewController(signInPresenter: signInPresenter)
    }
    
}
