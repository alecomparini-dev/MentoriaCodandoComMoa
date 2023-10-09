//  Created by Alessandro Comparini on 22/09/23.
//

import Foundation

public protocol SaveKeyChainUseCaseGateway {
    func save(_ value: String) throws
}
