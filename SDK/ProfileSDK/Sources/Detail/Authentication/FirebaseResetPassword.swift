//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation

import FirebaseAuth
import ProfileUseCaseGateway

public class FirebaseResetPassword: ResetPassword {
    private let auth: Auth
    
    public init(auth: Auth = .auth()) {
        self.auth = auth
    }

    public func reset(userEmail: String) async -> Bool {
        return await withCheckedContinuation { continuation in
            auth.sendPasswordReset(withEmail: userEmail) { error in
                if error != nil {
                    continuation.resume(returning: false)
                } else {
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    
}
