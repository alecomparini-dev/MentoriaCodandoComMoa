//  Created by Alessandro Comparini on 24/09/23.
//

import Foundation

public protocol FetchStorageProvider {
    
    func fetch<T>() throws -> [T]

}
