//  Created by Alessandro Comparini on 27/10/23.
//

import Foundation

public protocol DisableServiceUseCase {
    func disable(_ idService: Int, _ userIDAuth: String) async throws -> Bool
}
