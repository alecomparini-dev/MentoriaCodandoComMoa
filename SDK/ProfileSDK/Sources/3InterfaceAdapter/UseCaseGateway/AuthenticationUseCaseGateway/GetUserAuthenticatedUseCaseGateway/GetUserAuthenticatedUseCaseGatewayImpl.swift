//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation

import ProfileUseCases

public class GetUserAuthenticatedUseCaseGatewayImpl: GetUserAuthenticatedUseCaseGateway {
    
    private let userAuthenticator: UserAuthenticated
    
    public init(userAuthenticator: UserAuthenticated) {
        self.userAuthenticator = userAuthenticator
    }
    
    public func getUser() async throws -> UserAuthenticatedUseCaseModel {
        
        let userAuth: UserAuthenticatedGatewayDTO = try userAuthenticator.getUserIDAuthenticated()
               
        return UserAuthenticatedUseCaseModel(userIDAuth: userAuth.userID)
    }
    
    
}
