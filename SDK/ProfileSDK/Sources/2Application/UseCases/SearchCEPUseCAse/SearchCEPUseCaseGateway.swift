//  Created by Alessandro Comparini on 14/10/23.
//

import Foundation

public protocol SearchCEPUseCaseGateway {
    func get(_ cep: Int) async throws -> SearchCEPUseCaseDTO.Output?
}
