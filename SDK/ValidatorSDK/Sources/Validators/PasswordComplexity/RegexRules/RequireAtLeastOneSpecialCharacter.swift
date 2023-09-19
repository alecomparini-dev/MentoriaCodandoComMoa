//  Created by Alessandro Comparini on 18/09/23.
//

import Foundation

public class RequireAtLeastOneSpecialCharacter: RegexRules {
    public var regex: String
    
    public init(regex: String = "(?=.*[!@#$&*])") {
        self.regex = regex
    }
    
    public func perform(_ value: String) -> Bool {
        let range = NSRange(location: 0, length: value.utf16.count)
        let regex = try! NSRegularExpression(pattern: regex)
        return regex.firstMatch(in: value,options: [], range: range) != nil
    }
        
}
