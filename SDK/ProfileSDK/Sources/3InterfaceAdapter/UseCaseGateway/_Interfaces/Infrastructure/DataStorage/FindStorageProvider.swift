//  Created by Alessandro Comparini on 24/09/23.
//

import Foundation

public protocol FindStorageProvider {
    
    func findBy<T>(_ id: String) async throws -> T?

    func findBy<T, V>(column: String, value: V) async throws -> [T] 
}
