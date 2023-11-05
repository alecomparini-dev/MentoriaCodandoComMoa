//  Created by Alessandro Comparini on 03/11/23.
//

import Foundation

import ProfileUseCases

public class CheckBiometryUseCaseGatewayImpl: CheckBiometryUseCaseGateway {
    
    private let biometryAuthentication: BiometryAuthentication
    
    public init(biometryAuthentication: BiometryAuthentication) {
        self.biometryAuthentication = biometryAuthentication
    }
    
    public func check() -> CheckBiometryUseCaseDTO {
        let biometryGatewayDTO: BiometryAuthenticationGatewayDTO = biometryAuthentication.checkBiometry()
        return CheckBiometryUseCaseDTO(biometryTypes: biometryGatewayDTO.biometryTypes)
    }
    
}
