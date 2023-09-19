//  Created by Alessandro Comparini on 14/09/23.
//

import Foundation

public protocol PasswordComplexityValidation {
    func validate(password: String, complexityRules: PasswordComplexityValidationDTO.Input) -> Bool
    func getFailRules() -> [PasswordComplexityValidationDTO.Output.ComplexityPattern]
}
