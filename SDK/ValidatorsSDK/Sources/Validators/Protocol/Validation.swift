//  Created by Alessandro Comparini on 18/09/23.
//

import Foundation

public protocol Validator {
    func validate(data: [String: Any]) -> Bool
}
