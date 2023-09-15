//  Created by Alessandro Comparini on 14/09/23.
//

import Foundation
import ProfileUseCaseGateway
import FirebaseAuth

public class FirebaseEmailPasswordAuthentication: AuthenticationEmailPassword {
    
    private let auth: Auth
    
    public init(auth: Auth = .auth()) {
        self.auth = auth
    }
    

    public func createAuth(email: String, password: String) async throws -> UserId {
        
        return try await withCheckedThrowingContinuation { continuation in
            auth.createUser(withEmail: email, password: password) { result, error in
                if let error {
                    continuation.resume(throwing: error)
                }
                continuation.resume(returning: result?.user.uid ?? "" )
            }
        }
        
    }
    
    
    public func auth(email: String, password: String) async throws -> UserId {
        return try await withCheckedThrowingContinuation { continuation in
            auth.signIn(withEmail: email, password: password) { result, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume(returning: result?.user.uid ?? "" )
            }
        }
    }

    
    public func getUserIDAuthenticated() -> UserId? {
        return auth.currentUser?.uid
    }
    
}
