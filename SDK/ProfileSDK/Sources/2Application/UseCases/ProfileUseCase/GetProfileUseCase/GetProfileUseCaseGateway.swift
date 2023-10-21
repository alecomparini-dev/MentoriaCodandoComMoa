//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation

public protocol GetProfileUseCaseGateway {
    func getProfile(_ userIDAuth: String) async throws -> ProfileUseCaseDTO?
}
