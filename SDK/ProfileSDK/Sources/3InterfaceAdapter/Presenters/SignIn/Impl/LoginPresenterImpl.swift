//  Created by Alessandro Comparini on 14/09/23.
//

import Foundation

import ProfileUseCases


public protocol Validation {
    func validate() -> String?
}

public protocol LoginPresenterOutput: AnyObject {
    func error(_ error: String)
    func success(_ userId: String)
}

public class LoginPresenterImpl: LoginPresenter  {
    public weak var outputDelegate: LoginPresenterOutput?
    
    private let validations: [Validation]
    private let auth: AuthenticateUseCase
    
    public init(validations: [Validation], authUseCase: AuthenticateUseCase) {
        self.validations = validations
        self.auth = authUseCase
    }
    
    public func login(email: String, password: String) {
        
        Task {
            do {
                let userId = try await auth.emailPasswordAuth(email: email, password: password)
                DispatchQueue.main.async { [weak self] in
                    self?.outputDelegate?.success(userId)
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.outputDelegate?.error("Email ou Senha inválidos")
                }
                
            }
        }
        
    }
    
}
