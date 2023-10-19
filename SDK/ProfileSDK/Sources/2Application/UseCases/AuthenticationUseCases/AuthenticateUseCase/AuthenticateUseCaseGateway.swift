//  Created by Alessandro Comparini on 14/09/23.
//

import Foundation


public protocol AuthenticateUseCaseGateway {
    typealias UserId = String
    func auth(email: String, password: String) async throws -> UserId
}
