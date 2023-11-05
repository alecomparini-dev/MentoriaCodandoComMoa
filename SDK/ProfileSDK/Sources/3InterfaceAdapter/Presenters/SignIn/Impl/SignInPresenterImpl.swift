//  Created by Alessandro Comparini on 14/09/23.
//

import Foundation

import ProfileUseCases


public protocol SignInPresenterOutput: AnyObject {
    func errorSingIn(_ error: String)
    func successSingIn(_ userId: String)
//    func successCheckBiometry(message: String)
}

public class SignInPresenterImpl: SignInPresenter  {
    public weak var outputDelegate: SignInPresenterOutput?
    private let authUseCase: AuthenticateUseCase
    private let saveKeyChainEmailUseCase: SaveKeyChainRememberEmailUseCase
    private let getKeyChainEmailUseCase: GetKeyChainRememberEmailUseCase
    private let delKeyChainEmailUseCase: DeleteKeyChainRememberEmailUseCase
    private let checkBiometryUseCase: CheckBiometryUseCase
    private let emailValidator: EmailValidations
    
    public init(authUseCase: AuthenticateUseCase, saveKeyChainEmailUseCase: SaveKeyChainRememberEmailUseCase, getKeyChainEmailUseCase: GetKeyChainRememberEmailUseCase, delKeyChainEmailUseCase: DeleteKeyChainRememberEmailUseCase, checkBiometryUseCase: CheckBiometryUseCase, emailValidator: EmailValidations) {
        self.authUseCase = authUseCase
        self.saveKeyChainEmailUseCase = saveKeyChainEmailUseCase
        self.getKeyChainEmailUseCase = getKeyChainEmailUseCase
        self.delKeyChainEmailUseCase = delKeyChainEmailUseCase
        self.checkBiometryUseCase = checkBiometryUseCase
        self.emailValidator = emailValidator
    }

    public func getEmailKeyChain() -> String? {
        do {
            return try getKeyChainEmailUseCase.getEmail()
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
    
    private func validations(email: String, password: String) -> String? {
        if let failMsg = isValidRequiredFields(email: email, password: password) {
            return failMsg
        }
        
        return isValidEmail(email: email)
    }
    
    private func isValidEmail(email: String) -> String? {
        if !emailValidator.validate(email: email) {
            return "\nO email está fora do padrão \n"
        }
        return nil
    }
    
    private func isValidRequiredFields(email: String, password: String) -> String? {
        var fieldFails = [String]()
        
        if email.isEmpty {fieldFails.append("E-mail") }
        
        if password.isEmpty { fieldFails.append("Senha") }
        
        var failMsg: String?
        if (fieldFails.count > 1) {
            failMsg = "Os campos: \(fieldFails.description), devem estar preenchidos"
        }
        if (fieldFails.count == 1) {
            failMsg = "O campo: \(fieldFails.description), deve estar preenchido"
        }
        
        return failMsg
    }
    
    private func configRememberEmail(email: String, _ rememberPassword: Bool) throws {
        try delKeyChainEmailUseCase.delete()
        if rememberPassword {
            saveRememberEmail(email)
        }
    }
    
    public func login(email: String, password: String, rememberEmail: Bool = false) {
        if let msgInvalid = validations(email: email, password: password) {
            outputDelegate?.errorSingIn(msgInvalid)
            return
        }
        
        Task {
            do {
                let userId = try await authUseCase.emailPasswordAuth(email: email, password: password)
                
                try configRememberEmail(email: email, rememberEmail)
                
                let checkBiometryUseCaseDTO: CheckBiometryUseCaseDTO = try checkBiometryUseCase.check()
                if checkBiometryUseCaseDTO.biometryTypes != .noneBiometry {
                    
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.outputDelegate?.successSingIn(userId)
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.outputDelegate?.errorSingIn("Email ou Senha inválidos")
                }
            }
        }
        
    }
    
    
//  MARK: - PRIVATE AREA
    private func saveRememberEmail(_ email: String) {
        do {
            try saveKeyChainEmailUseCase.save(email)
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
}
