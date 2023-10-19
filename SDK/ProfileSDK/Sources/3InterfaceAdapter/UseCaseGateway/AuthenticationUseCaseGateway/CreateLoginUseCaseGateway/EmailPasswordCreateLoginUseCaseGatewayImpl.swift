//  Created by Alessandro Comparini on 15/09/23.
//

import Foundation

import ProfileUseCases


public class EmailPasswordCreateLoginUseCaseGatewayImpl: CreateLoginUseCaseGateway {
    private let authenticator: AuthenticationEmailPassword
    
    public init(authenticator: AuthenticationEmailPassword) {
        self.authenticator = authenticator
    }
    
    public func createLogin(email: String, password: String) async throws -> UserId {
        
        return try await withCheckedThrowingContinuation { continuation in

            authenticator.createAuth(email: email, password: password) { userId, authError in
                if let authError {
                    continuation.resume(throwing: authError.code)
                    return
                }
                continuation.resume(returning: userId ?? "")
            }
            
        }
    
    }
    
}
