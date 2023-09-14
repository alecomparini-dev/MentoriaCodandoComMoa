//  Created by Alessandro Comparini on 14/09/23.
//

import Foundation

public protocol Validation {
    func validate() -> String?
}

public protocol LoginPresenterOutput: AnyObject {
    func errorLogin()
    func successLogin()
}

public class LoginPresenterImpl: LoginPresenter  {
    public var outputDelegate: LoginPresenterOutput?
    
    private let validations: [Validation]
    
    public init(validations: [Validation]) {
        self.validations = validations
    }
    
    public func login() {
        
    }
    
}
