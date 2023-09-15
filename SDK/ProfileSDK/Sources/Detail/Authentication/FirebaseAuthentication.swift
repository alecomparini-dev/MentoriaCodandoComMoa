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
    

    public func createAuth(email: String, password: String, completion: @escaping (UserId?, AuthenticationError?) -> Void) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self else {return}
            if let error = error as? NSError {
                let error = makeAuthenticationError(error)
                completion(nil, error)
                return
            }
            completion(result?.user.uid, nil)
        }
    }
    
    
    public func auth(email: String, password: String, completion: @escaping (UserId?, AuthenticationError?) -> Void) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self else {return}
            if let error = error as? NSError {
                let error = makeAuthenticationError(error)
                completion(nil, error)
                return
            }
            completion(result?.user.uid, nil)
        }
    }

    
    public func getUserIDAuthenticated() -> UserId? {
        return auth.currentUser?.uid
    }
    
    
//  MARK: - PRIVATE AREA
    private func makeAuthenticationError(_ error: NSError) -> AuthenticationError {
        switch error.code {
            case 17026:
                return AuthenticationError(code: .passwordInvalid)
            
            case 17008, 17034:
                return AuthenticationError(code: .emailInvalid)
            
            case 17007:
                return AuthenticationError(code: .emailAlready)
            
            default:
                return AuthenticationError(code: .userOrPasswordInvalid)
        }
    
    }
}
