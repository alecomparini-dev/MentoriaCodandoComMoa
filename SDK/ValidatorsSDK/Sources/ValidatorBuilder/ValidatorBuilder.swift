//  Created by Alessandro Comparini on 18/09/23.
//

import Foundation


public class ValidationBuilder: Validator {
    
    private(set) weak emailValidator: EmailValidator?
    private(set) weak passwordComplexityValidator: PasswordComplexityValidator?

    private var validators: [Validator] = []
    
    public init() {}
    
    @discardableResult
    public func addValidation(_ validator: Validator) -> Self {
        validators.append(validator)
        return self
    }
    
    @discardableResult
    public func setRequiredField(_ builder: (_ build: RequiredFieldValidator) -> Void ) -> Self {
        let required = builder(RequiredFieldValidator())
        validators.append(required)
        return self
    }
    
    @discardableResult
    public func setEmailValidator(_ builder: (_ build: EmailValidator) -> Void ) -> Self {
        emailValidator = builder(EmailValidator())
        validators.append(required)
        return self
    }
    
    @discardableResult
    public func setCompareFields() -> Self {
        
        return self
    }
    
    @discardableResult
    public func setPasswordComplexity() -> Self {
        
        return self
    }
    @discardableResult
    public func setPasswordComplexity(_ builder: (_ build: PasswordComplexityValidator) -> Void ) -> Self {
        passwordComplexityValidator = builder(PasswordComplexityValidator())
        validators.append(passwordComplexityValidator)
        return self
    }
    
    
//  MARK: - VALIDATE
    
    public func validate(data: [String: Any]) -> Bool {
        for validator in validators {
            if validator.validate(data: data) {
                return true
            }
        }
        return false
    }
       
}
