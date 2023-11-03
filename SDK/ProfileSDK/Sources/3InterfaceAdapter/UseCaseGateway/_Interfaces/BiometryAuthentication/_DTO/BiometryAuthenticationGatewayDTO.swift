//  Created by Alessandro Comparini on 02/11/23.
//

import Foundation

public enum BiometryTypes {
    case faceID
    case touchID
    case none
}

public struct BiometryAuthenticationGatewayDTO {
    public var canEvaluatePolicy: Bool?
    public var biometryTypes: BiometryTypes?
    public var isAuthenticated: Bool?
    public var biometryCanceled: Bool?
}
