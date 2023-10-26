//  Created by Alessandro Comparini on 26/10/23.
//

import Foundation

import ProfileMainAdapter
import ProfileUseCases
import ProfileUseCaseGateway
import ProfileAuthentication


public class ProfileSDKMain {
    
    public init() {}
    
    public func getUserAuthenticated() async throws -> String? {
        
        let userAutenticator = FirebaseUserAuthenticated()
        
        let getUserAuthUserCaseGateway = GetUserAuthenticatedUseCaseGatewayImpl(userAuthenticator: userAutenticator)
        
        let getUserAuthUseCase = GetUserAuthenticatedUseCaseImpl(getUserAuthenticatedGateway: getUserAuthUserCaseGateway)
        
        let getUserAuthAdapter = GetUserAuthenticatedAdapterImpl(getUserAuthUseCase: getUserAuthUseCase)
        
        return try await getUserAuthAdapter.getUserAuth()
        
    }
    
}
