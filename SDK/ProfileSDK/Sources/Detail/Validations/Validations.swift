//  Created by Alessandro Comparini on 18/09/23.
//

import Foundation
import ProfilePresenters
import ValidatorSDK

public class Validations  {
    
    private var passwordComplexity: PasswordComplexityValidator?
    
    public init() {}

}


//  MARK: - EXTENSION - PasswordComplexityValidation

extension Validations: PasswordComplexityValidation {
    
    public func validate(password: String, complexityRules: PasswordComplexityValidationDTO.Input) -> Bool {
        passwordComplexity = PasswordComplexityValidatorBuilder()
            .setMinimumCharacterRequire(complexityRules.minimumCharacterRequire)
            .setMinimumNumber(complexityRules.minimumNumber)
            .setMinimumLowerCase(complexityRules.minimumLowerCase)
            .setMinimumUpperCase(complexityRules.minimumUpperCase)
            .setRequireAtLeastOneSpecialCharacter(complexityRules.leastOneSpecialCharacter)
        
        return passwordComplexity?.validate(password: password) ?? false
    }
    
    public func getFailRules() -> [PasswordComplexityValidationDTO.Output.ComplexityPattern] {
        guard let passwordComplexity else { return [] }
        
        let failsRules: [RegexRules] = passwordComplexity.getPasswordFail()
        
        let failsDTO: [PasswordComplexityValidationDTO.Output.ComplexityPattern] = failsRules.map({ fail in
            return convertComplexity(fail) ?? .leastOneSpecialCharacterRequire
        })
        
        return failsDTO
    }
    
    private func convertComplexity(_ regexRule: RegexRules) -> PasswordComplexityValidationDTO.Output.ComplexityPattern? {
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


//  MARK: - EXTENSION - EmailValidations
extension Validations: EmailValidations {
    
    public func validate(email: String) -> Bool {
        let emailValidator = EmailValidator()
        return emailValidator.validate(data: email)
    }
    
}



//  MARK: - EXTENSION - CPFValidations
extension Validations: CPFValidations {
    
    public func validate(cpf: String) -> Bool {
        let cpfValidator = CPFValidator()
        return cpfValidator.validate(cpf: cpf)
    }
    
}
