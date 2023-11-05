//  Created by Alessandro Comparini on 02/11/23.
//

import Foundation

public struct AuthenticateWithBiometricsUseCaseDTO {
    public var isAuthenticated: Bool?
    public var biometryType: BiometryTypes?
    public var biometryCanceled: BiometryCanceled?
    
    public init(isAuthenticated: Bool? = nil, biometryType: BiometryTypes? = nil, biometryCanceled: BiometryCanceled? = nil) {
        self.isAuthenticated = isAuthenticated
        self.biometryType = biometryType
        self.biometryCanceled = biometryCanceled
    }
}
