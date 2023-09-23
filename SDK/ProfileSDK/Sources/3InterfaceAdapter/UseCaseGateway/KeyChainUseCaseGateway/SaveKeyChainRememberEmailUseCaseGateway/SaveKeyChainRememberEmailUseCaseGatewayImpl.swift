//  Created by Alessandro Comparini on 22/09/23.
//

import Foundation
import ProfileUseCases

public class SaveKeyChainRememberEmailUseCaseGatewayImpl: SaveKeyChainRememberEmailUseCaseGateway {
    
    private let localStorageKeyChainProvider: InsertStorageProvider
    
    public init(localStorageKeyChainProvider: InsertStorageProvider) {
        self.localStorageKeyChainProvider = localStorageKeyChainProvider
    }
    
    public func save(_ email: String) throws {
        try localStorageKeyChainProvider.insert(email)
    }
    
    
}
