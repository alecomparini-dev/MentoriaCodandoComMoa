//  Created by Alessandro Comparini on 18/09/23.
//

import Foundation


public class PasswordComplexityValidator: Validator {
    private var passwordPattern = "(?=^.{6,}$)(?=^.*[A-Z].*$)(?=^.*[a-z].*$)(?=^.*\\d.*$)"

    public enum ComplexityPattern: String {
        case minimumCharacterRequire
        case minimumUpperCase
        case minimumLowerCase
        case minimumNumber
        case leastOneSpecialCharacterRequire
    }
    
    private var patternAdded: [ComplexityPattern] = []
    private var patternFail: [ComplexityPattern] = []
    private var passwordFieldName: String = ""
    
    public init() { }
    
    
//  MARK: - GET AREA
    public func getPasswordFail() -> [ComplexityPattern] {
        return patternFail
    }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setPasswordFieldName(_ passwordFieldName: String) -> Self {
        self.passwordFieldName = passwordFieldName
        return self
    }
    
    @discardableResult
    public func setMinimumCharacterRequire(_ minimum: Int) -> Self {
        self.passwordPattern = passwordPattern + "(?=^.{\(minimum),}$)"
        patternAdded.append(.minimumCharacterRequire)
        return self
    }
    
    @discardableResult
    public func setMinimumUpperCase(_ minimum: Int) -> Self {
        passwordPattern = passwordPattern + "(?=^"
        for _ in 1...minimum {
            passwordPattern = passwordPattern + ".*[A-Z]"
        }
        passwordPattern = passwordPattern + ".*$)"
        patternAdded.append(.minimumUpperCase)
        return self
    }

    @discardableResult
    public func setMinimumLowerCase(_ minimum: Int) -> Self {
        passwordPattern = passwordPattern + "(?=^"
        for _ in 1...minimum {
            passwordPattern = passwordPattern + ".*[a-z]"
        }
        passwordPattern = passwordPattern + ".*$)"
        patternAdded.append(.minimumLowerCase)
        return self
    }

    @discardableResult
    public func setMinimumNumber(_ minimum: Int) -> Self {
        passwordPattern = passwordPattern + "(?=^"
        for _ in 1...minimum {
            passwordPattern = passwordPattern + ".*\\d"
        }
        passwordPattern = passwordPattern + ".*$)"
        patternAdded.append(.minimumNumber)
        return self
    }
    
    @discardableResult
    public func setLeastOneSpecialCharacterRequire(_ minimum: Int) -> Self {
        self.passwordPattern = passwordPattern + "(?=.*[!@#$&*])"
        patternAdded.append(.leastOneSpecialCharacterRequire)
        return self
    }

    
    public func validate(data: [String : Any]) -> Bool {
        guard let password = data[passwordFieldName] as? String else { return false }
        
        passwordPattern = ".*"
        
        let range = NSRange(location: 0, length: password.utf16.count)
        
        let regex = try! NSRegularExpression(pattern: passwordPattern)
        
        let matches = regex.matches(in: password, options: [], range: range)
        
        for i in 0..<patternAdded.count {
            let matchRange = matches[i].range
            if matchRange.length == 0 {
                
            }
        }
        
        return true
        
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        
    }
    
}
