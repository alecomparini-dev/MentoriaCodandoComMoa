//  Created by Alessandro Comparini on 24/09/23.
//

import Foundation

public protocol GetKeyChainUseCaseGateway {
    func get(_ id: String) throws -> String?
}

