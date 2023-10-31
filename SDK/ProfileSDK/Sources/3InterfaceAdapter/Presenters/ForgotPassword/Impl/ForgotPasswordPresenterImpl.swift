//  Created by Alessandro Comparini on 31/10/23.
//

import Foundation

import ProfileUseCases

public protocol ForgotPasswordPresenterOutput: AnyObject {
    func successResetPassword()
    func errorResetPassword(title: String, message: String)
    func validations(validationsError: String?)
}

public class ForgotPasswordPresenterImpl: ForgotPasswordPresenter {
    public weak var outputDelegate: ForgotPasswordPresenterOutput?
    
    private let resetPasswordUseCase: ResetPasswordUseCase
    
    public init(resetPasswordUseCase: ResetPasswordUseCase) {
        self.resetPasswordUseCase = resetPasswordUseCase
    }
    
    public func resetPassword(_ userEmail: String?) {
        
        if !validations(userEmail) {
            return
        }
        
        guard let userEmail else {return}
        
        Task {
            if await resetPasswordUseCase.reset(userEmail: userEmail) {
                successResetPassword()
                return
            }
            errorResetPassword("Aviso", "Não foi possível resetar a senha. Favor tente novamente mais tarde")
        }
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func validations(_ email: String?) -> Bool {
        
        if email?.isEmpty ?? true {
            outputDelegate?.validations(validationsError: "Email obrigatório!")
            return false
        }

        return true
    }
    
    private func successResetPassword() {
        DispatchQueue.main.async { [weak self] in
            self?.outputDelegate?.successResetPassword()
        }
    }
    
    private func errorResetPassword(_ title: String, _ message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.outputDelegate?.errorResetPassword(title: title, message: message)
        }
    }
    
}
