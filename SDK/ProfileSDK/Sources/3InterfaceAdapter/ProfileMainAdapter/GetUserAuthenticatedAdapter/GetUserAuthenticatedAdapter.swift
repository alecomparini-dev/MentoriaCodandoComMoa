//  Created by Alessandro Comparini on 26/10/23.
//

import Foundation


public protocol GetUserAuthenticatedAdapter {
    func getUserAuth() async throws -> String? 
}
