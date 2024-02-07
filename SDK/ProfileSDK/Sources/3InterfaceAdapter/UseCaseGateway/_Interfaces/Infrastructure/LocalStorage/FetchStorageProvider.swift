//  Created by Alessandro Comparini on 24/09/23.
//

import Foundation

public protocol FetchStorageProvider {
    
    func fetch<T>() throws -> [T]

    func fetchByID<T>(_ id: String) throws -> T?

    func findByColumn<T, DataType>(column: String, value: DataType) throws -> [T] 
}
