//  Created by Alessandro Comparini on 31/10/23.
//

import UIKit

import LocalStorageDetails
import ProfileUI
import ProfilePresenters
import ProfileUseCases
import ProfileUseCaseGateway
import ProfileAuthentication
import ProfileLocalStorage

class ForgotPasswordViewControllerFactory {
    
    static func make() -> ForgotPasswordViewController {
        
        let keyChainProviderStrategy = KeyChainProvider(appName: K.Strings.appName)
        
        let localStorage = ProfileLocalStorage(storageProvider: keyChainProviderStrategy)
        
        let deleteKeyChainUseCaseGateway = DeleteKeyChainUseCaseGatewayImpl(localStorageKeyChainProvider: localStorage)
        
        let deleteAuthCredentialsUseCase = DeleteAuthCredentialsUseCaseImpl(delAuthCredentialsGateway: deleteKeyChainUseCaseGateway)
        
        let resetPassword = FirebaseResetPassword()
        
        let resetPasswordGateway = ResetPasswordUseCaseGatewayImpl(resetPassword: resetPassword)
        
        let resetPasswordUseCase = ResetPasswordUseCaseImpl(resetPasswordGateway: resetPasswordGateway )
                
        let forgotPasswordPresenter = ForgotPasswordPresenterImpl(resetPasswordUseCase: resetPasswordUseCase,
                                                                  delAuthCredentialsUseCase: deleteAuthCredentialsUseCase)
        
        return ForgotPasswordViewController(forgotPasswordPresenter: forgotPasswordPresenter)
        
    }
    
}
