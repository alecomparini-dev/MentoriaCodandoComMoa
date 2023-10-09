//  Created by Alessandro Comparini on 24/09/23.
//

import Foundation

public class GetKeyChainRememberEmailUseCaseImpl: GetKeyChainRememberEmailUseCase {
    
    private let getRememberEmailGateway: GetKeyChainUseCaseGateway
    
    public init(getRememberEmailGateway: GetKeyChainUseCaseGateway) {
        self.getRememberEmailGateway = getRememberEmailGateway
    }
    
    public func getEmail() throws -> String? {
        return try getRememberEmailGateway.get("email")
    }
    
}
