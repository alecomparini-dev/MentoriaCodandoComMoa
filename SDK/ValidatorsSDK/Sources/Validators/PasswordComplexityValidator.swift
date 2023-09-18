//  Created by Alessandro Comparini on 18/09/23.
//

import Foundation

public class PasswordComplexityValidator: Validator {
    private let passwordPatter = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{6,}$"
    
    private let passwordFieldName: String
    
    public init(passwordFieldName: String) {
        self.passwordFieldName = passwordFieldName
    }
    
    
    public func validate(data: [String : Any]) -> Bool {
        guard let password = data[passwordFieldName] as? String else { return false }
        
        let range = NSRange(location: 0, length: password.utf16.count)
        
        let regex = try! NSRegularExpression(pattern: passwordPatter)
        
        return regex.firstMatch(in: password, options: [], range: range) != nil
    }
    
    
}
