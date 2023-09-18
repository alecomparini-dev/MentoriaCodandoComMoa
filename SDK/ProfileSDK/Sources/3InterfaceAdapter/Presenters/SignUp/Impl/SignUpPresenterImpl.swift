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
    
    private let createLoginUseCase: CreateLoginUseCase
    private let passwordComplexityValidator: PasswordComplexity
    

    public init(createLoginUseCase: CreateLoginUseCase, passwordComplexityValidator: PasswordComplexity) {
        self.createLoginUseCase = createLoginUseCase
        self.passwordComplexityValidator = passwordComplexityValidator
    }
    
    public func createLogin(email: String, password: String) {
        
        if !passwordComplexityValidator.validate(password: password) {
            outputDelegate?.error(makeErrorPasswordComplexity())
            return
        }
        
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
        
        var msg = "A senha esta fora do padrão: acione \n"
        regexRulesFails.forEach { fail in
            switch fail {
            case .minimumCharacterRequire:
                msg = msg + "\n" + "no mínimo 6 caracteres"
            case .minimumUpperCase:
                msg = msg + "\n" + "um caracter maiúsculo"
            case .minimumLowerCase:
                msg = msg + "\n" + "um caracter minúsculo"
            case .minimumNumber:
                msg = msg + "\n" + "um número"
            case .leastOneSpecialCharacterRequire:
                msg = msg + "\n" + "um caracter especial"
            }
        }
        
        return msg
        
        
    }
    
}
