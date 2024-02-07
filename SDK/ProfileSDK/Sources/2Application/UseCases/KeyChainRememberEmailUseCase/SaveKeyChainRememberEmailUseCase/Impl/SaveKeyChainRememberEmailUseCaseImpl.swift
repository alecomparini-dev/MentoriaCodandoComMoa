//  Created by Alessandro Comparini on 22/09/23.
//

import Foundation

public class SaveKeyChainRememberEmailUseCaseImpl: SaveKeyChainRememberEmailUseCase {
    
    private let saveKeyChainGateway: SaveKeyChainUseCaseGateway
    
    public init(saveKeyChainGateway: SaveKeyChainUseCaseGateway) {
        self.saveKeyChainGateway = saveKeyChainGateway
    }
    
    public func save(_ email: String) throws {
        try saveKeyChainGateway.save(forKey: ProfileUseCasesConstants.email, [email] )
    }
    
}
