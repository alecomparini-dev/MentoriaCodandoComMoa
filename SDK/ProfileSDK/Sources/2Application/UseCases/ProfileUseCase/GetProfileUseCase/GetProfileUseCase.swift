//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation

public protocol GetProfileUseCase {
    func getProfile(_ userIDAuth: String) async throws -> GetProfileUseCaseDTO.Output?
}
