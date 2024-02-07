//  Created by Alessandro Comparini on 02/11/23.
//

import Foundation

public struct CheckBiometryUseCaseDTO {
    public var biometryTypes: BiometryTypes?
    
    public init(biometryTypes: BiometryTypes? = nil) {
        self.biometryTypes = biometryTypes
    }
}
