//  Created by Alessandro Comparini on 08/12/23.
//

import Foundation

public protocol ListClientsUseCase {
    func list(_ userIDAuth: String) async throws -> [ClientUseCaseDTO]
}
