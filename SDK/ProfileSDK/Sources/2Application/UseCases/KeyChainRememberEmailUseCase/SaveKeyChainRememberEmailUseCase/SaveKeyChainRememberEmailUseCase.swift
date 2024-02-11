//  Created by Alessandro Comparini on 22/09/23.
//

import Foundation

public protocol SaveKeyChainRememberEmailUseCase {
    func save(_ email: String) async throws
}
