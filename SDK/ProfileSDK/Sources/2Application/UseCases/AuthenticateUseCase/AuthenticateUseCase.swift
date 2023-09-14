//  Created by Alessandro Comparini on 14/09/23.
//

import Foundation

public protocol AuthenticateUseCase {
    func auth() async throws
}
