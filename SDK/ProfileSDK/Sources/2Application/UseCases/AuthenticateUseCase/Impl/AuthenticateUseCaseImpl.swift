//  Created by Alessandro Comparini on 14/09/23.
//

import Foundation

public class AuthenticateUseCaseImpl: AuthenticateUseCase {
    
    private let authUseCaseGateway: AuthenticateUseCaseGateway
    
    init(authUseCaseGateway: AuthenticateUseCaseGateway) {
        self.authUseCaseGateway = authUseCaseGateway
    }
    
    public func auth() async throws {
        try await authUseCaseGateway.auth()
    }
    
    
}
