//  Created by Alessandro Comparini on 19/09/23.
//

import Foundation
import ProfileDomain

struct MapperPasswordComplexityRulesToDTO {
    
    static func mapper(_ passwordComplexityRules: PasswordComplexityRules) -> PasswordComplexityRulesUseCaseDTO.Output {
        
        return PasswordComplexityRulesUseCaseDTO.Output(
            minimumCharacterRequire: passwordComplexityRules.minimumCharacterRequire,
            minimumNumber: passwordComplexityRules.minimumNumber,
            minimumLowerCase: passwordComplexityRules.minimumLowerCase,
            minimumUpperCase: passwordComplexityRules.minimumUpperCase,
            leastOneSpecialCharacter: passwordComplexityRules.leastOneSpecialCharacter)
    }
    
    
}
