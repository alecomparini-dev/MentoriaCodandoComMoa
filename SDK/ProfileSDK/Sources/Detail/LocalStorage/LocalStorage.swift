//  Created by Alessandro Comparini on 22/09/23.
//

import Foundation
import ProfileUseCaseGateway
import LocalStorageSDKMain
import LocalStorageDetails

public class LocalStorage  {
    
    private let storageProvider: StorageProviderStrategy
    
    public init(storageProvider: StorageProviderStrategy) {
        self.storageProvider = storageProvider
    }
    
}
    

//  MARK: - EXTENSION - InsertStorageProvider
extension LocalStorage: InsertStorageProvider {

    @discardableResult
    public func insert<T>(_ object: T) throws -> T? {
        if let resultInsert =  try storageProvider.insert(object) {
            return resultInsert
        }
        return nil
    }
    
    
}


//  MARK: - EXTENSION - InsertStorageProvider
extension LocalStorage: FetchStorageProvider {
    public func fetch<T>() throws -> [T] {
        return []
    }
    
    public func fetchByID<T>(_ id: String) throws -> T? {
        if let resultInsert: T =  try storageProvider.fetchById(id) {
            return resultInsert
        }
        return nil
    }
    
    public func findByColumn<T, DataType>(column: String, value: DataType) throws -> [T] {
        return []
    }
    

    
    
    
}

