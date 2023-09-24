//  Created by Alessandro Comparini on 24/09/23.
//

import Foundation

public class DeleteKeyChainRememberEmailUseCaseImpl: DeleteKeyChainRememberEmailUseCase {
    
    private let delRememberEmailGateway: DeleteKeyChainRememberEmailUseCaseGateway
    
    public init(delRememberEmailGateway: DeleteKeyChainRememberEmailUseCaseGateway) {
        self.delRememberEmailGateway = delRememberEmailGateway
    }
    
    public func delete() throws {
        try delRememberEmailGateway.delete()
    }
}
