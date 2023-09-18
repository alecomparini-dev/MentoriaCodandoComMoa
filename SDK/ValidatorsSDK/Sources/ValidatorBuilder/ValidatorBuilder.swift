//  Created by Alessandro Comparini on 18/09/23.
//

import Foundation


public class ValidationBuilder: Validator {
    
    private var validators: [Validator] = []
    
    public init() {}
    
    
    public func addValidation(_ validator: Validator) -> Self {
        validators.append(validator)
        return self
    }
    
    
    
    public func validate(data: [String: Any]) -> Bool {
        for validator in validators {
            if validator.validate(data: data) {
                return true
            }
        }
        return false
    }
       
}
