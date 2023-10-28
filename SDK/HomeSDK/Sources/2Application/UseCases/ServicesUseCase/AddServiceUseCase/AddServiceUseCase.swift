//  Created by Alessandro Comparini on 28/10/23.
//

import Foundation

public protocol AddServiceUseCase {
    func add(_ serviceUseCaseDTO: ServiceUseCaseDTO) async throws -> ServiceUseCaseDTO?
}
