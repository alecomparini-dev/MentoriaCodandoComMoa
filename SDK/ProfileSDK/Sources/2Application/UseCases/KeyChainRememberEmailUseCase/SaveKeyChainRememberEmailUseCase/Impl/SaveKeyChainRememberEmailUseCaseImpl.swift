//  Created by Alessandro Comparini on 22/09/23.
//

import Foundation

public class SaveKeyChainRememberEmailUseCaseImpl: SaveKeyChainRememberEmailUseCase {
    
    private let saveRememberEmailGateway: SaveKeyChainRememberEmailUseCaseGateway
    
    public init(saveRememberEmailGateway: SaveKeyChainRememberEmailUseCaseGateway) {
        self.saveRememberEmailGateway = saveRememberEmailGateway
    }
    
    public func save(_ email: String) throws {
        try saveRememberEmailGateway.save(email)
    }
    
}
