//  Created by Alessandro Comparini on 24/09/23.
//

import Foundation

import ProfileUseCases

public class DeleteKeyChainUseCaseGatewayImpl: DeleteKeyChainUseCaseGateway {
    
    private let localStorageKeyChainProvider: DeleteStorageProvider
    
    public init(localStorageKeyChainProvider: DeleteStorageProvider) {
        self.localStorageKeyChainProvider = localStorageKeyChainProvider
    }
    
    public func delete(_ id: String) async throws {
        try await localStorageKeyChainProvider.delete(id)
    }
}
