//  Created by Alessandro Comparini on 19/09/23.
//

import Foundation

import ProfileDomain


public class PasswordComplexityRulesUseCaseImpl: PasswordComplexityRulesUseCase {
    
    
    public func recoverRules() -> PasswordComplexityRulesUseCaseDTO.Output {
        return PasswordComplexityRulesUseCaseDTO.Output.init(passwordComplexityRules: PasswordComplexityRules())
    }
    
    
}
