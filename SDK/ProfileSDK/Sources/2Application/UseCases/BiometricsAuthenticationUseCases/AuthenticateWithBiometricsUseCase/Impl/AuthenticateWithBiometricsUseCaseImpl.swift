//  Created by Alessandro Comparini on 05/11/23.
//

import Foundation

public class AuthenticateWithBiometricsUseCaseImpl: AuthenticateWithBiometricsUseCase {
    private let authenticateWithBiometricGateway: AuthenticateWithBiometricsUseCaseGateway
    
    public init(authenticateWithBiometricGateway: AuthenticateWithBiometricsUseCaseGateway) {
        self.authenticateWithBiometricGateway = authenticateWithBiometricGateway
    }
    
    public func authenticate(reason: String, cancelTitle: String?) async -> AuthenticateWithBiometricsUseCaseDTO {
        return await authenticateWithBiometricGateway.authenticate(reason: reason, cancelTitle: cancelTitle)
    }
    
}
