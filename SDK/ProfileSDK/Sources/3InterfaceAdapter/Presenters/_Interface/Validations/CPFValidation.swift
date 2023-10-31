//  Created by Alessandro Comparini on 16/10/23.
//

import Foundation

public protocol CPFValidations {
    func validate(cpf: String) -> Bool
}
