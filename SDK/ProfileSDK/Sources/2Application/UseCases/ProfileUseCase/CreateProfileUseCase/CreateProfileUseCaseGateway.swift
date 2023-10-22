//  Created by Alessandro Comparini on 20/10/23.
//

import Foundation

public protocol CreateProfileUseCaseGateway {
    func create(_ profile: ProfileUseCaseDTO) async throws -> ProfileUseCaseDTO?
}
