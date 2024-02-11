//  Created by Alessandro Comparini on 06/11/23.
//

import Foundation

public class DeleteAuthCredentialsUseCaseImpl: DeleteAuthCredentialsUseCase {
    
    private let delAuthCredentialsGateway: DeleteKeyChainUseCaseGateway
    
    public init(delAuthCredentialsGateway: DeleteKeyChainUseCaseGateway) {
        self.delAuthCredentialsGateway = delAuthCredentialsGateway
    }
    
    public func delete() async throws {
        return try await delAuthCredentialsGateway.delete(ProfileUseCasesConstants.credentials)
    }

    
}
