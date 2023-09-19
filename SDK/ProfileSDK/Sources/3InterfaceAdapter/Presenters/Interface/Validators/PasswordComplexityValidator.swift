//  Created by Alessandro Comparini on 14/09/23.
//

import Foundation

public enum ComplexityPattern: String {
    case minimumCharacterRequire
    case minimumUpperCase
    case minimumLowerCase
    case minimumNumber
    case leastOneSpecialCharacterRequire
}

public protocol PasswordComplexityValidator {
    func validate(password: String) -> Bool
    func getFailRules() -> [ComplexityPattern]
}
