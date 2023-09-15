
//  Created by Alessandro Comparini on 30/08/23.
//

import Foundation

import ProfileUseCases

public class EmailPasswordAuthenticateUseCaseGatewayImpl: AuthenticateUseCaseGateway {
    private let authentication: AuthenticationEmailPassword
    
    public init(authentication: AuthenticationEmailPassword) {
        self.authentication = authentication
    }
    
    public func auth(email: String, password: String) async throws -> UserId {
        return try await authentication.auth(email: email, password: password)
    }
    
    
}
