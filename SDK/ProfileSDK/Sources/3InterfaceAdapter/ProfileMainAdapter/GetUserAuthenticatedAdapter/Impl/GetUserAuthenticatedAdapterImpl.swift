//  Created by Alessandro Comparini on 26/10/23.
//

import Foundation
import ProfileUseCases

public class GetUserAuthenticatedAdapterImpl: GetUserAuthenticatedAdapter {
    
    private let getUserAuthUseCase: GetUserAuthenticatedUseCase
    
    public init(getUserAuthUseCase: GetUserAuthenticatedUseCase) {
        self.getUserAuthUseCase = getUserAuthUseCase
    }
    
    
    public func getUserAuth() async throws -> String? {
        let outputDTO = try await getUserAuthUseCase.getUser()
        return outputDTO.userIDAuth
    }

    
}
