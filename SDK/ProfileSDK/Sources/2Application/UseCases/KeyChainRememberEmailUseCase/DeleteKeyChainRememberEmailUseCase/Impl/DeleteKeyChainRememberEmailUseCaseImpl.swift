//  Created by Alessandro Comparini on 24/09/23.
//

import Foundation

public class DeleteKeyChainRememberEmailUseCaseImpl: DeleteKeyChainRememberEmailUseCase {
    
    private let delRememberEmailGateway: DeleteKeyChainUseCaseGateway
    
    public init(delRememberEmailGateway: DeleteKeyChainUseCaseGateway) {
        self.delRememberEmailGateway = delRememberEmailGateway
    }
    
    public func delete() async throws {
        try await delRememberEmailGateway.delete(ProfileUseCasesConstants.email)
    }
}
