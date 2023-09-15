
//  Created by Alessandro Comparini on 14/09/23.
//

import Foundation


public protocol AuthenticationEmailPassword {
    typealias UserId = String
    func createAuth(email: String, password: String) async throws -> UserId
    func auth(email: String, password: String) async throws -> UserId
    func getUserIDAuthenticated() -> UserId?
}
