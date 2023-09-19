//  Created by Alessandro Comparini on 19/09/23.
//

import Foundation

import ProfileDomain


public class PasswordComplexityRulesUseCaseImpl: PasswordComplexityRulesUseCase {
    
    public init() {}
    
    public func recoverRules() -> PasswordComplexityRulesUseCaseDTO.Output {
        let complexityRules =  PasswordComplexityRules()
        return MapperPasswordComplexityRulesToDTO.mapper(complexityRules)
    }
    
    
}
