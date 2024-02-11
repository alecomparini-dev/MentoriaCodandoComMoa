//  Created by Alessandro Comparini on 15/09/23.
//

import Foundation

import ProfileUseCases


public protocol SignUpPresenterOutput: AnyObject {
    func error(_ error: String)
    func success(_ userId: String)
}

public class SignUpPresenterImpl: SignUpPresenter  {
    public weak var outputDelegate: SignUpPresenterOutput?
    
    private var complexityRules: PasswordComplexityValidationDTO.Input?
    
    private let createLoginUseCase: CreateLoginUseCase
    private let passwordComplexityRulesUseCase: PasswordComplexityRulesUseCase
    private let passwordComplexityValidator: PasswordComplexityValidation
    private let emailValidator: EmailValidations
    private let delKeyChainEmailUseCase: DeleteKeyChainRememberEmailUseCase

    public init(createLoginUseCase: CreateLoginUseCase,
                passwordComplexityRulesUseCase: PasswordComplexityRulesUseCase,
                passwordComplexityValidator: PasswordComplexityValidation,
                emailValidator: EmailValidations,
                delKeyChainEmailUseCase: DeleteKeyChainRememberEmailUseCase ) {
        self.createLoginUseCase = createLoginUseCase
        self.passwordComplexityRulesUseCase = passwordComplexityRulesUseCase
        self.passwordComplexityValidator = passwordComplexityValidator
        self.emailValidator = emailValidator
        self.delKeyChainEmailUseCase = delKeyChainEmailUseCase
    }
    
    
    public func createLogin(email: String, password: String, passwordConfirmation: String) {
        if let msgInvalid = validations(email: email, password: password, passwordConfirmation: passwordConfirmation) {
            outputDelegate?.error(msgInvalid)
            return
        }
        createLoginAsync(email: email, password: password)
    }
    
    
    
//  MARK: - PRIVATE AREA
    
    private func validations(email: String, password: String, passwordConfirmation: String) -> String? {
        var failsMessage: String?

        if let failMsg = isValidRequiredFields(email: email, password: password, passwordConfirmation: passwordConfirmation) {
            return failMsg
        }
        
        failsMessage = isValidEmail(email: email)
        
        if let failMsg = isValidPasswordComplexity(password: password) {
            failsMessage = (failsMessage ?? "") + failMsg
        }

        if let failMsg = isValidConfirmationPassword(password: password, passwordConfirmation: passwordConfirmation) {
//            return failMsg
            failsMessage = (failsMessage ?? "") + failMsg
        }

        return failsMessage
    }

    private func isValidRequiredFields(email: String, password: String, passwordConfirmation: String) -> String? {
        var fieldFails = [String]()
        
        if email.isEmpty {fieldFails.append("E-mail") }
        
        if password.isEmpty { fieldFails.append("Senha") }
        
        if passwordConfirmation.isEmpty { fieldFails.append("Confirmação senha")  }
        
        var failMsg: String?
        if (fieldFails.count > 1) {
            failMsg = "Os campos: \(fieldFails.description), devem estar preenchidos"
        }
        if (fieldFails.count == 1) {
            failMsg = "O campo: \(fieldFails.description), deve estar preenchido"
        }
        
        return failMsg
    }
    
    private func isValidConfirmationPassword(password: String, passwordConfirmation: String) -> String? {
        var failMsg: String?
        
        if password != passwordConfirmation {
            failMsg = "\nA confirmação de senha não está igual a senha cadastrada"
        }
        
        return failMsg
    }
    
    private func isValidPasswordComplexity(password: String) -> String? {
        let complexityRules = makePasswordComplexityRulesInput()
        self.complexityRules = complexityRules
        if !passwordComplexityValidator.validate(password: password, complexityRules: complexityRules) {
            return makeErrorPasswordComplexity()
        }
        return nil
    }
    
    private func isValidEmail(email: String) -> String? {
        if !emailValidator.validate(email: email) {
            return "\nO email está fora do padrão \n"
        }
        return nil
    }

    private func makePasswordComplexityRulesInput() -> PasswordComplexityValidationDTO.Input {
        let passwordRules = passwordComplexityRulesUseCase.recoverRules()
        
        return PasswordComplexityValidationDTO.Input(
            minimumCharacterRequire: passwordRules.minimumCharacterRequire,
            minimumNumber: passwordRules.minimumNumber,
            minimumLowerCase: passwordRules.minimumLowerCase,
            minimumUpperCase: passwordRules.minimumUpperCase,
            leastOneSpecialCharacter: passwordRules.leastOneSpecialCharacter)
    }

    private func createLoginAsync(email: String, password: String) {
        Task {
            do {
                let userId = try await createLoginUseCase.createLogin(email: email, password: password)
                DispatchQueue.main.async { [weak self] in
                    self?.outputDelegate?.success(userId)
                }
            } catch let errorDomain as AuthenticationDomainError {
                DispatchQueue.main.async { [weak self] in
                    var errorMsg = ""
                    switch errorDomain {
                    case .emailAlready:
                        errorMsg = "O Email já está em uso por outra conta"
                    case .emailInvalid:
                        errorMsg = "Email inválido"
                    case .passwordInvalid:
                        errorMsg = "Senha inválida"
                    default:
                        errorMsg = "Erro ao criar usuário"
                    }
                    self?.outputDelegate?.error(errorMsg)
                }
            }
            
            try await delKeyChainEmailUseCase.delete()
        }
    }

    private func makeErrorPasswordComplexity() -> String {
        let regexRulesFails = passwordComplexityValidator.getFailRules()
        
        var msg = "A senha está fora do padrão: Adicione"
        regexRulesFails.forEach { fail in
            switch fail {
            case .minimumCharacterRequire:
                msg = msg + "\n" + "no mínimo \(complexityRules?.minimumCharacterRequire ?? 1) caracteres"
            case .minimumUpperCase:
                msg = msg + "\n" + "\(complexityRules?.minimumUpperCase ?? 1) caracter maiúsculo"
            case .minimumLowerCase:
                msg = msg + "\n" + "\(complexityRules?.minimumLowerCase ?? 1 ) caracter minúsculo"
            case .minimumNumber:
                msg = msg + "\n" + "\(complexityRules?.minimumNumber ?? 1) número"
            case .leastOneSpecialCharacterRequire:
                if complexityRules?.leastOneSpecialCharacter ?? false {
                    msg = msg + "\n" + "1 caracter especial"
                }
            }
        }
        
        return msg
        
        
    }
    
}
