//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation

import FirebaseAuth
import ProfileUseCaseGateway

public class FirebaseUserAuthenticated: UserAuthenticated {
    
    private let auth: Auth
    
    public init(auth: Auth = .auth()) {
        self.auth = auth
    }
    
    public func getUserIDAuthenticated() throws -> UserAuthenticatedGatewayDTO {
        
        guard let currentUserID: String = auth.currentUser?.uid else {
            throw AuthenticationError(code: .userNotAuthenticated)
        }
        
        return UserAuthenticatedGatewayDTO (
            userID: currentUserID,
            email: auth.currentUser?.email,
            phoneNumber: auth.currentUser?.phoneNumber,
            isEmailVerified: auth.currentUser?.isEmailVerified ?? false,
            displayName: auth.currentUser?.displayName,
            photoURL: auth.currentUser?.photoURL?.description
        )
        
    }
    
    
    
    
}
