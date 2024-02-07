//
//  SignInViewControllerFactory.swift
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


class SignInViewControllerFactory {

    static func make(callBiometricsFlow: Bool?) -> SignInViewController {
        
        let authUseCase = makeAuthUseCase()
        
        let keyChainProviderStrategy = KeyChainProvider(appName: K.Strings.appName)
        
        let localStorage = ProfileLocalStorage(storageProvider: keyChainProviderStrategy)
        
        let saveKeyChainEmailUseCase = makeSaveKeyChainEmailUseCase(localStorage)
        
        let getKeyChainEmailUseCase = makeGetKeyChainEmailUseCase(localStorage)
        
        let delKeyChainEmailUseCase = makeDelKeyChainEmailUseCase(localStorage)
        
        let getAuthCredentialsUseCase = makeGetAuthCredentialsUseCase(localStorage)
        
        let saveAuthCredentialsUseCase = makeSaveAuthCredentialsUseCase(localStorage)
        
        let delAuthCredentialsUseCase = makeDeleteAuthCredentialsUseCase(localStorage)
        
        let checkBiometryUseCase = makeCheckBiometryUseCase()
        
        let authenticateWithBiometricsUseCase = makeAuthenticateWithBiometricsUseCase()
            
        let validation = Validations()
        
        let signInPresenter = SignInPresenterImpl(authUseCase: authUseCase,
                                                  saveKeyChainEmailUseCase: saveKeyChainEmailUseCase,
                                                  getKeyChainEmailUseCase: getKeyChainEmailUseCase,
                                                  delKeyChainEmailUseCase: delKeyChainEmailUseCase,
                                                  getAuthCredentialsUseCase: getAuthCredentialsUseCase,
                                                  saveAuthCredentialsUseCase: saveAuthCredentialsUseCase, 
                                                  delAuthCredentialsUseCase: delAuthCredentialsUseCase,
                                                  checkBiometryUseCase: checkBiometryUseCase,
                                                  authenticateWithBiometricsUseCase: authenticateWithBiometricsUseCase,
                                                  emailValidator: validation)
        
        return SignInViewController(signInPresenter: signInPresenter, callBiometricsFlow: callBiometricsFlow ?? false)
    }
    
    
//  MARK: - PRIVATE AREA
    
    static private func makeAuthUseCase() -> AuthenticateUseCaseImpl {
        let authentication = FirebaseEmailPasswordAuthentication()
        let authUseCaseGateway = EmailPasswordAuthenticateUseCaseGatewayImpl(authentication: authentication)
        return AuthenticateUseCaseImpl(authUseCaseGateway: authUseCaseGateway)
    }
    
    static private func makeCheckBiometryUseCase() -> CheckBiometryUseCaseImpl{
        let biometryCheckAuthentication = LocalAuthentication(context: LAContext())
        let checkBiometryGateway = CheckBiometryUseCaseGatewayImpl(biometryAuthentication: biometryCheckAuthentication)
        return CheckBiometryUseCaseImpl(checkBiometryGateway: checkBiometryGateway)
    }
    
    static private func makeAuthenticateWithBiometricsUseCase() -> AuthenticateWithBiometricsUseCaseImpl{
        let biometryAuthentication = LocalAuthentication(context: LAContext())
        let authenticateWithBiometricGateway = AuthenticateWithBiometricsUseCaseGatewayImpl(biometryAuthentication: biometryAuthentication)
        return AuthenticateWithBiometricsUseCaseImpl(authenticateWithBiometricGateway: authenticateWithBiometricGateway)
    }
    
    static private func makeDelKeyChainEmailUseCase(_ localStorage: ProfileLocalStorage) -> DeleteKeyChainRememberEmailUseCaseImpl{
        let delKeyChainEmailUseCaseGateway = DeleteKeyChainUseCaseGatewayImpl(localStorageKeyChainProvider: localStorage)
        return DeleteKeyChainRememberEmailUseCaseImpl(delRememberEmailGateway: delKeyChainEmailUseCaseGateway)
    }
    
    static private func makeGetKeyChainEmailUseCase(_ localStorage: ProfileLocalStorage) -> GetKeyChainRememberEmailUseCaseImpl{
        let getKeyChainEmailUseCaseGateway = GetKeyChainUseCaseGatewayImpl(localStorageKeyChainProvider: localStorage)
        return GetKeyChainRememberEmailUseCaseImpl(getRememberEmailGateway: getKeyChainEmailUseCaseGateway)
    }
    
    static private func makeSaveKeyChainEmailUseCase(_ localStorage: ProfileLocalStorage) -> SaveKeyChainRememberEmailUseCaseImpl{
        let saveKeyChainGateway = SaveKeyChainUseCaseGatewayImpl(localStorageKeyChainProvider: localStorage)
        return SaveKeyChainRememberEmailUseCaseImpl(saveKeyChainGateway: saveKeyChainGateway)
    }
    
    static private func makeDeleteAuthCredentialsUseCase(_ localStorage: ProfileLocalStorage) -> DeleteAuthCredentialsUseCaseImpl {
        let delKeyChainGateway = DeleteKeyChainUseCaseGatewayImpl(localStorageKeyChainProvider: localStorage)
        return DeleteAuthCredentialsUseCaseImpl(delAuthCredentialsGateway: delKeyChainGateway)
    }
    
    static private func makeGetAuthCredentialsUseCase(_ localStorage: ProfileLocalStorage) -> GetAuthCredentialsUseCaseImpl{
        let getAuthCredentialsGateway = GetKeyChainUseCaseGatewayImpl(localStorageKeyChainProvider: localStorage)
        return GetAuthCredentialsUseCaseImpl(getAuthCredentialsGateway: getAuthCredentialsGateway)
    }
    
    static private func makeSaveAuthCredentialsUseCase(_ localStorage: ProfileLocalStorage) -> SaveAuthCredentialsUseCaseImpl{
        let saveAuthCredentialsGateway = SaveKeyChainUseCaseGatewayImpl(localStorageKeyChainProvider: localStorage)
        return SaveAuthCredentialsUseCaseImpl(saveAuthCredentialsGateway: saveAuthCredentialsGateway)
    }
    
}
