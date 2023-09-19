//  Created by Alessandro Comparini on 19/09/23.
//

import Foundation

public enum PasswordComplexityValidatorDTO {
    
    public struct Input {
        public let minimumCharacterRequire: Int
        public let minimumNumber: Int
        public let minimumLowerCase: Int
        public let minimumUpperCase: Int
        public let leastOneSpecialCharacter: Bool?
        
        public init(minimumCharacterRequire: Int,
                    minimumNumber: Int,
                    minimumLowerCase: Int,
                    minimumUpperCase: Int,
                    leastOneSpecialCharacter: Bool?) {
            self.minimumCharacterRequire = minimumCharacterRequire
            self.minimumNumber = minimumNumber
            self.minimumLowerCase = minimumLowerCase
            self.minimumUpperCase = minimumUpperCase
            self.leastOneSpecialCharacter = leastOneSpecialCharacter
        }
    }
    
    public struct Output {
        public enum ComplexityPattern {
            case minimumCharacterRequire
            case minimumUpperCase
            case minimumLowerCase
            case minimumNumber
            case leastOneSpecialCharacterRequire
        }
        
        
    }
        
}
