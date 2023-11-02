//  Created by Alessandro Comparini on 02/11/23.
//

import Foundation

public struct CheckBiometryUseCaseDTO {
    public var canEvaluatePolicy: Bool?
    public var biometryTypes: BiometryTypes?
    
    public init(canEvaluatePolicy: Bool? = nil, biometryTypes: BiometryTypes? = nil) {
        self.canEvaluatePolicy = canEvaluatePolicy
        self.biometryTypes = biometryTypes
    }
}
