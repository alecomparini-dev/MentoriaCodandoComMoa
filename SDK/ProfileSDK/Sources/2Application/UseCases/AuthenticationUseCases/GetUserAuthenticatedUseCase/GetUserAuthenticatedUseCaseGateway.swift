//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation


public protocol GetUserAuthenticatedUseCaseGateway {
    func getUser() async throws -> UserAuthenticatedUseCaseModel
}
