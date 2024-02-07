//  Created by Alessandro Comparini on 05/11/23.
//

import Foundation

import ProfileUseCases

public class AuthenticateWithBiometricsUseCaseGatewayImpl: AuthenticateWithBiometricsUseCaseGateway {
    
    private let biometryAuthentication: BiometryAuthentication
    
    public init(biometryAuthentication: BiometryAuthentication) {
        self.biometryAuthentication = biometryAuthentication
    }
    
    public func authenticate(reason: String, cancelTitle: String?) async -> AuthenticateWithBiometricsUseCaseDTO {
        
        let biometryGatewayDTO: BiometryAuthenticationGatewayDTO = await biometryAuthentication.authenticate(reason: reason, cancelTitle: cancelTitle)
        
        return AuthenticateWithBiometricsUseCaseDTO(isAuthenticated: biometryGatewayDTO.isAuthenticated,
                                                    biometryType: biometryGatewayDTO.biometryTypes,
                                                    biometryCanceled: biometryGatewayDTO.biometryCanceled)
    }
    
}
