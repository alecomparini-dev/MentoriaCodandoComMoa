//  Created by Alessandro Comparini on 28/10/23.
//

import Foundation

public protocol SaveServiceUseCaseGateway {
    func save(_ serviceUseCaseDTO: ServiceUseCaseDTO) async throws -> ServiceUseCaseDTO?
}
