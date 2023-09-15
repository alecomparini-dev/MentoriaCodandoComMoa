//  Created by Alessandro Comparini on 14/09/23.
//

import Foundation

public class AuthenticateUseCaseImpl: AuthenticateUseCase {
    private let authUseCaseGateway: AuthenticateUseCaseGateway
    
    public init(authUseCaseGateway: AuthenticateUseCaseGateway) {
        self.authUseCaseGateway = authUseCaseGateway
    }
    
    public func emailPasswordAuth(email: String, password: String) async throws -> UserId {
        return try await authUseCaseGateway.auth(email: email, password: password)
    }
    
}
