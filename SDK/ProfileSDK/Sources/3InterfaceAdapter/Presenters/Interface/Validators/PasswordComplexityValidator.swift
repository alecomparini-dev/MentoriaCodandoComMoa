//  Created by Alessandro Comparini on 14/09/23.
//

import Foundation


public protocol PasswordComplexityValidator {
    func validate(password: String, complexityRules: PasswordComplexityValidatorDTO.Input) -> Bool
    func getFailRules() -> [PasswordComplexityValidatorDTO.Output.ComplexityPattern]
}
