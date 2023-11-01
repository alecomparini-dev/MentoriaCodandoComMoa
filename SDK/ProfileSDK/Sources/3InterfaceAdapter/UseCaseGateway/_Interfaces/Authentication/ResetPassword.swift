//  Created by Alessandro Comparini on 31/10/23.
//

import Foundation

public protocol ResetPassword {
    func reset(userEmail: String) async -> Bool
}
