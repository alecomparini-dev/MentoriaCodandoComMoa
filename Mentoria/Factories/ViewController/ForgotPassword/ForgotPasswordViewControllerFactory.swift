//  Created by Alessandro Comparini on 31/10/23.
//

import UIKit

import DataStorageSDK
import ProfileUI
import ProfilePresenters
import ProfileUseCases
import ProfileUseCaseGateway
import ProfileAuthentication
import ProfileDataStorage

class ForgotPasswordViewControllerFactory {
    
    static func make() -> ForgotPasswordViewController {
        
        let keyChainDataProvider = KeyChainDataStorageProvider(appName: K.Strings.appName)
        
        let profileDataStorage = ProfileDataStorage(dataStorage: keyChainDataProvider)
        
        let deleteKeyChainUseCaseGateway = DeleteKeyChainUseCaseGatewayImpl(localStorageKeyChainProvider: profileDataStorage)
        
        let deleteAuthCredentialsUseCase = DeleteAuthCredentialsUseCaseImpl(delAuthCredentialsGateway: deleteKeyChainUseCaseGateway)
        
        let getAuthCredentialsGateway = GetKeyChainUseCaseGatewayImpl(localStorageKeyChainProvider: profileDataStorage)
        
        let getAuthCredentialsUseCase = GetAuthCredentialsUseCaseImpl(getAuthCredentialsGateway: getAuthCredentialsGateway)
        
        let resetPassword = FirebaseResetPassword()
        
        let resetPasswordGateway = ResetPasswordUseCaseGatewayImpl(resetPassword: resetPassword)
        
        let resetPasswordUseCase = ResetPasswordUseCaseImpl(resetPasswordGateway: resetPasswordGateway )
            
        let forgotPasswordPresenter = ForgotPasswordPresenterImpl(resetPasswordUseCase: resetPasswordUseCase, 
                                                                  getAuthCredentialsUseCase: getAuthCredentialsUseCase,
                                                                  delAuthCredentialsUseCase: deleteAuthCredentialsUseCase)
        
        return ForgotPasswordViewController(forgotPasswordPresenter: forgotPasswordPresenter)
        
    }
    
}
