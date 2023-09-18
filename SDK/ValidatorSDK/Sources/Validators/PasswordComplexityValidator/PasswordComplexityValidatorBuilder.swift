//  Created by Alessandro Comparini on 18/09/23.
//

import Foundation


public class PasswordComplexityValidatorBuilder: PasswordComplexityValidator {
    private var passwordPattern = ""

    private var patternAdded: [RegexRules] = []
    private var patternFail: [RegexRules] = []
    
    public init() { }
    
    
//  MARK: - GET AREA
    public func getPasswordFail() -> [RegexRules] {
        return patternFail
    }
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setRegexRule(_ regexRule: RegexRules) -> Self {
        patternAdded.append(regexRule)
        return self
    }
    
    @discardableResult
    public func setMinimumCharacterRequire(_ minimum: Int) -> Self {
        let regexRule = MinimumCharacterRequire(minimum: minimum)
        patternAdded.append(regexRule)
        return self
    }
    
    @discardableResult
    public func setMinimumUpperCase(_ minimum: Int) -> Self {
        let regexRule = MinimumUpperCaseCharacter(minimum: minimum)
        patternAdded.append(regexRule)
        return self
    }

    @discardableResult
    public func setMinimumLowerCase(_ minimum: Int) -> Self {
        let regexRule = MinimumLowerCaseCharacter(minimum: minimum)
        patternAdded.append(regexRule)
        return self
    }

    @discardableResult
    public func setMinimumNumber(_ minimum: Int) -> Self {
        let regexRule = MinimumNumber(minimum: minimum)
        patternAdded.append(regexRule)
        return self
    }
    
    @discardableResult
    public func setRequireAtLeastOneSpecialCharacter() -> Self {
        let regexRule = RequireAtLeastOneSpecialCharacter()
        patternAdded.append(regexRule)
        return self
    }

    
    public func validate(password: String) -> Bool {
        patternAdded.forEach { regex in
            if !regex.perform(password) {
                patternFail.append(regex)
            }
        }
        if !patternFail.isEmpty {
            return false
        }
        return true
        
    }
    
    
}
