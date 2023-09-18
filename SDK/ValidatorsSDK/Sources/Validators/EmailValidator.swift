//  Created by Alessandro Comparini on 18/09/23.
//


import Foundation

public final class EmailValidator: Validator {
    private let patter = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    private let emailFieldName: String
    
    public init(emailFieldName: String) {
        self.emailFieldName = emailFieldName
    }
    
    public func validate(data: [String: Any]) -> Bool {
        guard let email = data[emailFieldName] as? String else { return false }
        
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: patter)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
    
}
