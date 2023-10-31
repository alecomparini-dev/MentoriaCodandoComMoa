//  Created by Alessandro Comparini on 31/10/23.
//

import UIKit

import ProfileUI
import ProfilePresenters
import ProfileUseCases
import ProfileUseCaseGateway
import ProfileAuthentication

class ForgotPasswordViewControllerFactory {
    
    static func make() -> ForgotPasswordViewController {
        
        let resetPassword = FirebaseResetPassword()
        
        let resetPasswordGateway = ResetPasswordUseCaseGatewayImpl(resetPassword: resetPassword)
        
        let resetPasswordUseCase = ResetPasswordUseCaseImpl(resetPasswordGateway: resetPasswordGateway )
        
        let forgotPasswordPresenter = ForgotPasswordPresenterImpl(resetPasswordUseCase: resetPasswordUseCase)
        
        return ForgotPasswordViewController(forgotPasswordPresenter: forgotPasswordPresenter)
        
    }
    
}
