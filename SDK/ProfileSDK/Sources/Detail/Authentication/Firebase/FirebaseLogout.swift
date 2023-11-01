//  Created by Alessandro Comparini on 01/11/23.
//

import Foundation
import FirebaseAuth
import ProfileUseCaseGateway

public class FirebaseSignOut: Logout {
    
    private let auth: Auth
    
    public init(auth: Auth = .auth()) {
        self.auth = auth
    }
    
    public func logout() throws {
        try auth.signOut()
    }
    
    
}
