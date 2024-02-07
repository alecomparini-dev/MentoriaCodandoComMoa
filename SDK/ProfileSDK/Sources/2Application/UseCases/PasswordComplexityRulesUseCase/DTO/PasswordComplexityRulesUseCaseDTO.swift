
//  Created by Alessandro Comparini on 19/09/23.
//

import Foundation
import ProfileDomain

public enum PasswordComplexityRulesUseCaseDTO {
    
    public struct Input {
    }
    
    public struct Output {
        public let minimumCharacterRequire: Int
        public let minimumNumber: Int
        public let minimumLowerCase: Int
        public let minimumUpperCase: Int
        public let leastOneSpecialCharacter: Bool?
        
        init(minimumCharacterRequire: Int, minimumNumber: Int, minimumLowerCase: Int, minimumUpperCase: Int, leastOneSpecialCharacter: Bool?) {
            self.minimumCharacterRequire = minimumCharacterRequire
            self.minimumNumber = minimumNumber
            self.minimumLowerCase = minimumLowerCase
            self.minimumUpperCase = minimumUpperCase
            self.leastOneSpecialCharacter = leastOneSpecialCharacter
        }
    }
        
}
