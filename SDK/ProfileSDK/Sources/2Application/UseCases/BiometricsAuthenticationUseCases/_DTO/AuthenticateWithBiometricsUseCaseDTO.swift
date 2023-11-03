//  Created by Alessandro Comparini on 02/11/23.
//

import Foundation

public struct AuthenticateWithBiometricsUseCaseDTO {
    public var isAuthenticatedByBiometry: Bool?
    public var biometryType: BiometryTypes?
    public var biometryCanceled: Bool?
}
