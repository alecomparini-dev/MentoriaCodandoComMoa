//  Created by Alessandro Comparini on 19/09/23.
//

import Foundation

public protocol EmailValidations {
    func validate(email: String) -> Bool
}
