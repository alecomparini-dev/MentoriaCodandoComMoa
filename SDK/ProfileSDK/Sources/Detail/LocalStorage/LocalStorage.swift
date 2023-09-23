//  Created by Alessandro Comparini on 22/09/23.
//

import Foundation
import ProfileUseCaseGateway
import LocalStorageSDKMain
import LocalStorageDetails

public class LocalStorage: InsertStorageProvider {
    
    private let storageProvider: ProviderStrategy
    
    public init(storageProvider: ProviderStrategy) {
        self.storageProvider = storageProvider
    }
    
    @discardableResult
    public func insert<T>(_ object: T) throws -> T {
        return try storageProvider.insert(object)
        
    }
    
    
}

