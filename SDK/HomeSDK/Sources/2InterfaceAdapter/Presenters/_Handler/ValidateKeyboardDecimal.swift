//  Created by Alessandro Comparini on 30/10/23.
//

import Foundation

public func validateKeyboardDecimal(text: String?, _ character: String) -> Bool {
   guard let text else { return true}
    let separators: [String] = [".", ","]
    if separators.contains(character) {
        return !separators.contains { separator in
            return text.contains(separator)
        }
    }
    return true
}
