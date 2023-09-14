
//  Created by Alessandro Comparini on 14/09/23.
//

import Foundation

public protocol AuthenticationProvider {
    func auth() async throws
    func createAuth() async throws
}
