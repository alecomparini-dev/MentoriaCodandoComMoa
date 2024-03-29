//  Created by Alessandro Comparini on 22/09/23.
//

import Foundation

public protocol InsertStorageProvider {
    @discardableResult
    func insert<T>(_ object: T) async throws -> T?
    
    @discardableResult
    func insert<T>(key: String, _ value: T) async throws -> T?
}
