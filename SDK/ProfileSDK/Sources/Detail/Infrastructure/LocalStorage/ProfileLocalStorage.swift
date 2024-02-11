//  Created by Alessandro Comparini on 22/09/23.
//

import Foundation
import ProfileUseCaseGateway
import LocalStorageDetails

public class ProfileLocalStorage  {
    
    private let storageProvider: StorageProviderStrategy
    
    public init(storageProvider: StorageProviderStrategy) {
        self.storageProvider = storageProvider
    }
    
}
    

//  MARK: - EXTENSION - InsertStorageProvider
extension ProfileLocalStorage: InsertStorageProvider {
    
    public func insert<T>(_ object: T) throws -> T? {
        if let resultInsert = try storageProvider.insert(object) {
            return resultInsert
        }
        return nil
    }
    
    public func insert<T>(key: String, _ value: T) throws -> T? {
        if let resultInsert = try storageProvider.insert(key: key, value) {
            return resultInsert
        }
        return nil
    }
    
}


//  MARK: - EXTENSION - DeleteStorageProvider
extension ProfileLocalStorage: DeleteStorageProvider {

    public func delete<T>(_ object: T) throws {
        try storageProvider.delete(object)
    }
        
}


//  MARK: - EXTENSION - FetchStorageProvider
extension ProfileLocalStorage: FetchStorageProvider {
    public func fetch<T>() throws -> [T] {
        return []
    }
    
    
}


extension ProfileLocalStorage: FindStorageProvider {
    public func findBy<T>(_ id: String) async throws -> T? {
        if let resultInsert: T = try storageProvider.fetchById(id) {
            return resultInsert
        }
        return nil
    }
    
    public func findBy<T, V>(column: String, value: V) async throws -> [T] {
        return []
    }
    
}
