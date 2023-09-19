//  Created by Alessandro Comparini on 18/09/23.
//

import Foundation
import ProfilePresenters
import ValidatorSDK

public class Validators  {
    private var passwordComplexity: PasswordComplexity?
    
    public init() {}

}


//  MARK: - EXTENSION - PasswordComplexity
extension Validators: PasswordComplexityValidator {
    
    public func validate(password: String) -> Bool {
        passwordComplexity = PasswordComplexityBuilder()
            .setMinimumCharacterRequire(6)
            .setMinimumNumber(1)
            .setMinimumLowerCase(1)
            .setMinimumUpperCase(1)
        
        return passwordComplexity?.validate(password: password ) ?? false
    }
    
    public func getFailRules() -> [ComplexityPattern] {
        guard let passwordComplexity else { return [] }
        
        let failsRules: [RegexRules] = passwordComplexity.getPasswordFail()
        
        let failsDTO: [ComplexityPattern] = failsRules.map({ fail in
            return convertComplexity(fail) ?? .leastOneSpecialCharacterRequire
        })
        
        return failsDTO
    }
    
    private func convertComplexity(_ regexRule: RegexRules) -> ComplexityPattern? {
        switch regexRule {
            case is MinimumCharacterRequire:
                return .minimumCharacterRequire
            
            case is MinimumUpperCaseCharacter:
                return .minimumUpperCase
                
            case is MinimumLowerCaseCharacter:
                return .minimumLowerCase
                
            case is MinimumNumber:
                return .minimumNumber
                
            case is RequireAtLeastOneSpecialCharacter:
                return .leastOneSpecialCharacterRequire
                
            default:
                return nil
        }
        
    }

}
