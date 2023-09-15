//  Created by Alessandro Comparini on 14/09/23.
//

import Foundation

public protocol AuthenticateUseCase {
    typealias UserId = String
    func emailPasswordAuth(email: String, password: String) async throws -> UserId
}
