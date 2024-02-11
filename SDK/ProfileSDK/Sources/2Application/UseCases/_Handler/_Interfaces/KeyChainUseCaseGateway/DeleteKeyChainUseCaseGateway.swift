//  Created by Alessandro Comparini on 22/09/23.
//

import Foundation

public protocol DeleteKeyChainUseCaseGateway {
    func delete(_ key: String) async throws
}
