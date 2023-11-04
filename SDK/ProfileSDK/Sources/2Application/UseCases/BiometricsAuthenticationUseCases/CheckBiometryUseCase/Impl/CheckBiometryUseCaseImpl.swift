//  Created by Alessandro Comparini on 02/11/23.
//

import Foundation


public class CheckBiometryUseCaseImpl: CheckBiometryUseCase {

    private let checkBiometryGateway: CheckBiometryUseCaseGateway
    
    public init(checkBiometryGateway: CheckBiometryUseCaseGateway) {
        self.checkBiometryGateway = checkBiometryGateway
    }
    
    public func check() -> CheckBiometryUseCaseDTO {
        return checkBiometryGateway.check()
    }
    
}
