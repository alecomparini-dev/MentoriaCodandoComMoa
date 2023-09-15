//  Created by Alessandro Comparini on 15/09/23.
//

import Foundation

import ProfileUseCases


public class EmailPasswordCreateLoginUseCaseGatewayImpl: CreateLoginUseCaseGateway {
    private let authentication: AuthenticationEmailPassword
    
    public init(authentication: AuthenticationEmailPassword) {
        self.authentication = authentication
    }
    
    public func createLogin(email: String, password: String) async throws -> UserId {
        
        return try await withCheckedThrowingContinuation { continuation in

            authentication.createAuth(email: email, password: password) { [weak self] userId, authError in
                guard let self else {return}
                if let authError {
                    continuation.resume(throwing: authError.code)
                    return
                }
                continuation.resume(returning: userId ?? "")
            }
            
        }
    
    }
    
}
