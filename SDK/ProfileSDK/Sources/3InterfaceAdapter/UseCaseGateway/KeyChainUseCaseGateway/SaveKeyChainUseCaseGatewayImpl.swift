//  Created by Alessandro Comparini on 29/09/23.
//

import Foundation
import ProfileUseCases

public class SaveKeyChainUseCaseGatewayImpl: SaveKeyChainUseCaseGateway {
    
    private let localStorageKeyChainProvider: InsertStorageProvider
    
    public init(localStorageKeyChainProvider: InsertStorageProvider) {
        self.localStorageKeyChainProvider = localStorageKeyChainProvider
    }
    
    public func save(_ value: String) throws {
        try localStorageKeyChainProvider.insert(value)
    }
    
    
}
