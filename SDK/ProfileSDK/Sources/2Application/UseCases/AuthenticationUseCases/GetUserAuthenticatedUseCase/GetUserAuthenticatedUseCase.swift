//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation

public protocol GetUserAuthenticatedUseCase {
    func getUser() async throws -> UserAuthenticatedUseCaseDTO.Output
}
