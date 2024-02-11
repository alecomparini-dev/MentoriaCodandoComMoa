//  Created by Alessandro Comparini on 29/09/23.
//

import Foundation
import ProfileUseCases

public class SaveKeyChainUseCaseGatewayImpl: SaveKeyChainUseCaseGateway {
    
    private let localStorageKeyChainProvider: InsertStorageProvider
    
    public init(localStorageKeyChainProvider: InsertStorageProvider) {
        self.localStorageKeyChainProvider = localStorageKeyChainProvider
    }

    public func save(forKey: String, _ value: Any) async throws {
        try await localStorageKeyChainProvider.insert(key: forKey, value)
    }

    
}
