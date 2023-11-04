//  Created by Alessandro Comparini on 02/11/23.
//

import Foundation
import ProfileUseCases

public enum BiometryCanceled {
    case userCancel
    case appCancel
    case others
}

public struct BiometryAuthenticationGatewayDTO {
    public var biometryTypes: BiometryTypes?
    public var isAuthenticated: Bool?
    public var biometryCanceled: BiometryCanceled?
    
    public init(biometryTypes: BiometryTypes? = nil,
                isAuthenticated: Bool? = nil,
                biometryCanceled: BiometryCanceled? = nil) {
        self.biometryTypes = biometryTypes
        self.isAuthenticated = isAuthenticated
        self.biometryCanceled = biometryCanceled
    }
}
