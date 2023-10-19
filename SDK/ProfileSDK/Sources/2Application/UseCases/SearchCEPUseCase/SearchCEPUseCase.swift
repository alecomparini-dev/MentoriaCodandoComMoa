//  Created by Alessandro Comparini on 14/10/23.
//

import Foundation

public protocol SearchCEPUseCase {
    func get(_ cep: String) async throws -> SearchCEPUseCaseDTO.Output?
}
