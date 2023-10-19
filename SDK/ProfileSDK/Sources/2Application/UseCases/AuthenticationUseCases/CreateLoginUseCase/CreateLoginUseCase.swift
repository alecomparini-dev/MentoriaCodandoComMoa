//  Created by Alessandro Comparini on 15/09/23.
//

import Foundation


public protocol CreateLoginUseCase {
    typealias UserId = String
    func createLogin(email: String, password: String) async throws -> UserId
}
