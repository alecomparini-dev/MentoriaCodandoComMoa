//  Created by Alessandro Comparini on 24/09/23.
//

import Foundation

import ProfileUseCases

public class DeleteKeyChainRememberEmailUseCaseGatewayImpl: DeleteKeyChainRememberEmailUseCaseGateway {
    
    private let localStorageKeyChainProvider: DeleteStorageProvider
    
    public init(localStorageKeyChainProvider: DeleteStorageProvider) {
        self.localStorageKeyChainProvider = localStorageKeyChainProvider
    }
    
    public func delete() throws {
        try localStorageKeyChainProvider.delete("email")
    }
    
}
