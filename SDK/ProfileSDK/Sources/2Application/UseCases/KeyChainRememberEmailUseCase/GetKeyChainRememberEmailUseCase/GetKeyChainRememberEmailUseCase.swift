//  Created by Alessandro Comparini on 22/09/23.
//

import Foundation

public protocol GetKeyChainRememberEmailUseCase {
    func getEmail() async throws -> String?
}
