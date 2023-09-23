//  Created by Alessandro Comparini on 22/09/23.
//

import Foundation

public protocol SaveKeyChainRememberEmailUseCaseGateway {
    func save(_ email: String) throws
}
