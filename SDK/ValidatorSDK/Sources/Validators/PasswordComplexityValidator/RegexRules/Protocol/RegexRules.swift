//  Created by Alessandro Comparini on 18/09/23.
//

import Foundation

public protocol RegexRules {
    var regex: String  { get set }
    func perform(_ value: String) -> Bool
}
