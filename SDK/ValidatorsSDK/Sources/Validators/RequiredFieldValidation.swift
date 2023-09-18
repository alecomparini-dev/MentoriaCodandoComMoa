//  Created by Alessandro Comparini on 18/09/23.
//

import Foundation

public final class RequiredFieldValidation: Validator {
    private let fieldName: String
    
    public init(fieldName: String) {
        self.fieldName = fieldName
    }
    
    public func validate(data: [String : Any]) -> Bool {
        guard let fieldName = data[fieldName] as? String else { return false }
        
        if fieldName.isEmpty { return false }
        
        return true
    }
    
}
