//  Created by Alessandro Comparini on 24/09/23.
//

import Foundation

import ProfileUseCases

public class GetKeyChainUseCaseGatewayImpl: GetKeyChainUseCaseGateway {
    
    private let localStorageKeyChainProvider: FindStorageProvider
    
    public init(localStorageKeyChainProvider: FindStorageProvider) {
        self.localStorageKeyChainProvider = localStorageKeyChainProvider
    }
    
    public func get(_ key: String) async throws -> Any? {
        return try await localStorageKeyChainProvider.findBy(key)
    }
    
}
