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
    
    private let validations: [Validation]
    private let createLoginUseCase: CreateLoginUseCase
    
    public init(validations: [Validation], createLoginUseCase: CreateLoginUseCase) {
        self.validations = validations
        self.createLoginUseCase = createLoginUseCase
    }
    
    public func createLogin(email: String, password: String) {
        
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
    
}
