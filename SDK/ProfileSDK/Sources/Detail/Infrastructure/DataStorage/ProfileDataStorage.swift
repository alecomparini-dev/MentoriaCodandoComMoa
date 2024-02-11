//  Created by Alessandro Comparini on 11/02/24.
//

import Foundation

import ProfileUseCaseGateway
import DataStorageSDK

public class ProfileDataStorage {
       
    private let dataStorage: DataStorageProviderStrategy
    
    public init(dataStorage: DataStorageProviderStrategy) {
        self.dataStorage = dataStorage
    }
    
}



//  MARK: - EXTENSION
extension ProfileDataStorage: InsertStorageProvider {
    public func insert<T>(_ object: T) async throws -> T? {
        if let resultInsert = try await dataStorage.create(object) {
            return resultInsert
        }
        return nil
    }
    
    public func insert<T>(key: String, _ value: T) async throws -> T? {
        if let resultInsert = try await dataStorage.create(key, value) {
            return resultInsert
        }
        return nil
    }
    
    
}



//  MARK: - EXTENSION
extension ProfileDataStorage: FindStorageProvider {
    
    public func findBy<T>(_ id: String) async throws -> T? {
        return try await dataStorage.findBy(id)
    }
    
    public func findBy<T, V>(column: String, value: V) async throws -> [T] {
        return try await dataStorage.findBy(column: column, value: value)
    }
    
}



//  MARK: - EXTENSION
extension ProfileDataStorage: DeleteStorageProvider {
    public func delete<T>(_ object: T) async throws {
        try await dataStorage.delete(object)
    }
    
}


