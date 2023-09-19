//  Created by Alessandro Comparini on 18/09/23.
//

import Foundation
import ProfilePresenters

public protocol PasswordComplexity {
    
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
    func setRequireAtLeastOneSpecialCharacter(_ required: Bool?) -> Self 

    func validate(password: String) -> Bool
    
}
