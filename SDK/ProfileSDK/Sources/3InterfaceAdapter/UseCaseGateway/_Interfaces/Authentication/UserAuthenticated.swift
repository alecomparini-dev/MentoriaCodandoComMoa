//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation

public protocol UserAuthenticated {
    func getUserIDAuthenticated() throws -> UserAuthenticatedGatewayDTO
}
