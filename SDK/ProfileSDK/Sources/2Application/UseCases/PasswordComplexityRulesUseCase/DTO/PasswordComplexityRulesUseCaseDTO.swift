
//  Created by Alessandro Comparini on 19/09/23.
//

import Foundation
import ProfileDomain

public enum PasswordComplexityRulesUseCaseDTO {
    
    public struct Input {
    }
    
    public struct Output {
        public let passwordComplexityRules: PasswordComplexityRules
    }
        
}
