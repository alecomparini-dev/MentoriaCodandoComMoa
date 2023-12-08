//  Created by Alessandro Comparini on 08/12/23.
//

import Foundation

import HomeDomain

public protocol ListClientsUseCaseGateway {
    func list(_ userIDAuth: String) async throws -> [ClientModel]
}
