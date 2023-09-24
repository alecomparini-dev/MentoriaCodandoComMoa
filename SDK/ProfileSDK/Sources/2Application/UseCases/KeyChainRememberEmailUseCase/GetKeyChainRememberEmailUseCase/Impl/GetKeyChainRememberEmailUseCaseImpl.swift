//  Created by Alessandro Comparini on 24/09/23.
//

import Foundation

public class GetKeyChainRememberEmailUseCaseImpl: GetKeyChainRememberEmailUseCase {
    
    private let getRememberEmailGateway: GetKeyChainRememberEmailUseCaseGateway
    
    public init(getRememberEmailGateway: GetKeyChainRememberEmailUseCaseGateway) {
        self.getRememberEmailGateway = getRememberEmailGateway
    }
    
    public func getEmail() throws -> String? {
        return try getRememberEmailGateway.getEmail()
    }
    
}
