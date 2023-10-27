//  Created by Alessandro Comparini on 23/10/23.
//

import Foundation

public protocol ListServicesUseCaseGateway {
    func list(_ userIDAuth: String) async throws -> [ServiceDTO]?
}
