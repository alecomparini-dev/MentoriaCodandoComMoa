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
    private let passwordComplexityValidator: PasswordComplexityValidations

    public init(createLoginUseCase: CreateLoginUseCase, passwordComplexityRulesUseCase: PasswordComplexityRulesUseCase, passwordComplexityValidator: PasswordComplexityValidations) {
        self.createLoginUseCase = createLoginUseCase
        self.passwordComplexityRulesUseCase = passwordComplexityRulesUseCase
        self.passwordComplexityValidator = passwordComplexityValidator
    }
    
    public func createLogin(email: String, password: String) {
        let complexityRules = makePasswordComplexityRulesInput()
        self.complexityRules = complexityRules
        if !passwordComplexityValidator.validate(password: password,
                                                 complexityRules: complexityRules) {
            outputDelegate?.error(makeErrorPasswordComplexity())
            return
        }
        
        createLoginAsync(email: email, password: password)
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
        }
    }
    
    private func makeErrorPasswordComplexity() -> String {
        let regexRulesFails = passwordComplexityValidator.getFailRules()
        
        var msg = "A senha esta fora do padrão: Adicione \n"
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
