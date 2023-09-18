//  Created by Alessandro Comparini on 18/09/23.
//

import Foundation


public protocol PasswordComplexityValidator {
    
    func getPasswordFail() -> [RegexRules]
    
    @discardableResult
    func setMinimumCharacterRequire(_ minimum: Int) -> Self
    
    @discardableResult
    func setMinimumUpperCase(_ minimum: Int) -> Self

    @discardableResult
    func setMinimumLowerCase(_ minimum: Int) -> Self

    @discardableResult
    func setMinimumNumber(_ minimum: Int) -> Self
    
    @discardableResult
    func setRequireAtLeastOneSpecialCharacter() -> Self

    func validate(password: String) -> Bool
    
}
