//  Created by Alessandro Comparini on 18/09/23.
//


import Foundation

public final class EmailValidator {
    
    private let patter = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,}$"
    
    public init(){}
    
    public func validate(email: Any) -> Bool {
        guard let email = email as? String else { return false }
        
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: patter)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
    
}
