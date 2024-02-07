//  Created by Alessandro Comparini on 19/09/23.
//

import Foundation


public struct PasswordComplexityRules {
    public let minimumCharacterRequire: Int
    public let minimumNumber: Int
    public let minimumLowerCase: Int
    public let minimumUpperCase: Int
    public let leastOneSpecialCharacter: Bool?
    
    public init(minimumCharacterRequire: Int = 6,
                minimumNumber: Int = 1,
                minimumLowerCase: Int = 1,
                minimumUpperCase: Int = 1,
                leastOneSpecialCharacter: Bool? = nil) {
        self.minimumCharacterRequire = minimumCharacterRequire
        self.minimumNumber = minimumNumber
        self.minimumLowerCase = minimumLowerCase
        self.minimumUpperCase = minimumUpperCase
        self.leastOneSpecialCharacter = leastOneSpecialCharacter
    }
    
    
}
