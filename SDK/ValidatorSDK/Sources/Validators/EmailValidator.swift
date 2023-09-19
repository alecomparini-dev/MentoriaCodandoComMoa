//  Created by Alessandro Comparini on 18/09/23.
//


import Foundation

public final class EmailValidator: Validator {
    private let patter = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,}$"
    
    private let fieldName: String
    
    public init(fieldName: String) {
        self.fieldName = fieldName
    }
    
    public func validate(data: [String: Any]) -> Bool {
        guard let email = data[fieldName] as? String else { return false }
        
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: patter)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
    
}
