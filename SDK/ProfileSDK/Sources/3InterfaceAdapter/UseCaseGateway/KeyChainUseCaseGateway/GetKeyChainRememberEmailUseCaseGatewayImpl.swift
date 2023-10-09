//  Created by Alessandro Comparini on 24/09/23.
//

import Foundation

import ProfileUseCases

public class GetKeyChainRememberEmailUseCaseGatewayImpl: GetKeyChainUseCaseGateway {
    
    private let localStorageKeyChainProvider: FetchStorageProvider
    
    public init(localStorageKeyChainProvider: FetchStorageProvider) {
        self.localStorageKeyChainProvider = localStorageKeyChainProvider
    }
    
    public func get(_ id: String) throws -> String? {
        return try localStorageKeyChainProvider.fetchByID(id)
    }
    
}
