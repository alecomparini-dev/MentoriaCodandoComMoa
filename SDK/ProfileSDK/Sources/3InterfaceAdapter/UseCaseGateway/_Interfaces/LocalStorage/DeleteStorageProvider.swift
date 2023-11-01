//  Created by Alessandro Comparini on 24/09/23.
//

import Foundation

public protocol DeleteStorageProvider {
    func delete<T>(_ object: T) throws
}
