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
    
    public func validate(password: String, complexityRules: PasswordComplexityValidatorDTO.Input) -> Bool {
        
        passwordComplexity = PasswordComplexityBuilder()
            .setMinimumCharacterRequire(complexityRules.minimumCharacterRequire)
            .setMinimumNumber(complexityRules.minimumNumber)
            .setMinimumLowerCase(complexityRules.minimumLowerCase)
            .setMinimumUpperCase(complexityRules.minimumUpperCase)
            .setRequireAtLeastOneSpecialCharacter(complexityRules.leastOneSpecialCharacter)
        
        return passwordComplexity?.validate(password: password) ?? false
    }
    
    public func getFailRules() -> [PasswordComplexityValidatorDTO.Output.ComplexityPattern] {
        guard let passwordComplexity else { return [] }
        
        let failsRules: [RegexRules] = passwordComplexity.getPasswordFail()
        
        let failsDTO: [PasswordComplexityValidatorDTO.Output.ComplexityPattern] = failsRules.map({ fail in
            return convertComplexity(fail) ?? .leastOneSpecialCharacterRequire
        })
        
        return failsDTO
    }
    
    private func convertComplexity(_ regexRule: RegexRules) -> PasswordComplexityValidatorDTO.Output.ComplexityPattern? {
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
