//  Created by Alessandro Comparini on 15/09/23.
//

import Foundation

import DataStorageSDK
import ProfileAuthentication
import ProfilePresenters
import ProfileUI
import ProfileUseCases
import ProfileUseCaseGateway
import ProfileValidations
import ProfileDataStorage


class SignUpViewControllerFactory {

    static func make() -> SignUpViewController {
        
        let authentication = FirebaseEmailPasswordAuthentication()
        
        let createLoginUseCaseGateway = EmailPasswordCreateLoginUseCaseGatewayImpl(authenticator: authentication)
        
        let createLoginUseCase = CreateLoginUseCaseImpl(createLoginUseCaseGateway: createLoginUseCaseGateway)
        
        let passwordComplexityRulesUseCase = PasswordComplexityRulesUseCaseImpl()
        
        let validation = Validations()
        
        let keyChainDataProvider = KeyChainDataStorageProvider(appName: K.Strings.appName)
        
        let profileDataStorage = ProfileDataStorage(dataStorage: keyChainDataProvider)
        
        let delKeyChainEmailUseCaseGateway = DeleteKeyChainUseCaseGatewayImpl(localStorageKeyChainProvider: profileDataStorage)
        
        let delKeyChainEmailUseCase = DeleteKeyChainRememberEmailUseCaseImpl(delRememberEmailGateway: delKeyChainEmailUseCaseGateway)
        
        let signUpPresenter = SignUpPresenterImpl(createLoginUseCase: createLoginUseCase,
                                                  passwordComplexityRulesUseCase: passwordComplexityRulesUseCase,
                                                  passwordComplexityValidator: validation,
                                                  emailValidator: validation, 
                                                  delKeyChainEmailUseCase: delKeyChainEmailUseCase)
        
        return SignUpViewController(signUpPresenter: signUpPresenter)
    }

}
