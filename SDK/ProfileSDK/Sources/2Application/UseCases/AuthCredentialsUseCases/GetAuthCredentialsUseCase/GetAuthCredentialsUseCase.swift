//  Created by Alessandro Comparini on 06/11/23.
//

import Foundation

public typealias CredentialsAlias = (email: String, password: String)

public enum BiometricPreference: Equatable {
    case notResponded
    case notAccepted
    case accepted(credentials: CredentialsAlias)
    
    public static func == (lhs: BiometricPreference, rhs: BiometricPreference) -> Bool {
        switch (lhs, rhs) {
        case (.notResponded, .notResponded):
            return true
        
        case (.notAccepted, .notAccepted):
            return true

        case (.accepted, .accepted):
            return true
            
        default:
            return false
        }
    }

}

public protocol GetAuthCredentialsUseCase {
    func getCredentials(_ userEmail: String) throws -> BiometricPreference
}
