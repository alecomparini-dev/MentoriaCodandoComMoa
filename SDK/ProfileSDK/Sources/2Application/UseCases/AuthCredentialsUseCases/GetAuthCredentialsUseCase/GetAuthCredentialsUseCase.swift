//  Created by Alessandro Comparini on 06/11/23.
//

import Foundation

public typealias CredentialsAlias = (email: String, password: String)

public enum BiometricPreference {
    case notResponded
    case notAccepted
    case accepted(credentials: CredentialsAlias)
}

public protocol GetAuthCredentialsUseCase {
    func getCredentials() throws -> BiometricPreference
}
