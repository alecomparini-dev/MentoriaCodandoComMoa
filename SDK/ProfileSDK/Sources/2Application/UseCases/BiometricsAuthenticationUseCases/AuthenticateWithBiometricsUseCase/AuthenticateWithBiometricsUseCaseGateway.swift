//  Created by Alessandro Comparini on 05/11/23.
//

import Foundation

public protocol AuthenticateWithBiometricsUseCaseGateway {
    func authenticate(reason: String, cancelTitle: String?) async -> AuthenticateWithBiometricsUseCaseDTO
}
