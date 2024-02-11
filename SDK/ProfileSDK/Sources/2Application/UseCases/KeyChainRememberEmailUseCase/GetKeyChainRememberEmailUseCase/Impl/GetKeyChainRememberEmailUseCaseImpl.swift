//  Created by Alessandro Comparini on 24/09/23.
//

import Foundation

public class GetKeyChainRememberEmailUseCaseImpl: GetKeyChainRememberEmailUseCase {
    
    private let getRememberEmailGateway: GetKeyChainUseCaseGateway
    
    public init(getRememberEmailGateway: GetKeyChainUseCaseGateway) {
        self.getRememberEmailGateway = getRememberEmailGateway
    }
    
    public func getEmail() async throws -> String? {
        if let email = try await getRememberEmailGateway.get(ProfileUseCasesConstants.email) as? [String] {
            return email[0]
        }
        return nil
    }
    
}
