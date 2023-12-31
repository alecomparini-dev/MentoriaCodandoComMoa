//  Created by Alessandro Comparini on 24/09/23.
//

import Foundation

import ProfileUseCases

public class GetKeyChainUseCaseGatewayImpl: GetKeyChainUseCaseGateway {
    
    private let localStorageKeyChainProvider: FetchStorageProvider
    
    public init(localStorageKeyChainProvider: FetchStorageProvider) {
        self.localStorageKeyChainProvider = localStorageKeyChainProvider
    }
    
    public func get(_ key: String) throws -> Any? {
        return try localStorageKeyChainProvider.fetchByID(key)
    }
    
}
