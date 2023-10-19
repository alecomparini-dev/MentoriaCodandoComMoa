
//  Created by Alessandro Comparini on 14/09/23.
//

import Foundation


public protocol AuthenticationEmailPassword {
    typealias UserId = String
    func createAuth(email: String, password: String, completion: @escaping (UserId?, AuthenticationError?) -> Void)
    
    func auth(email: String, password: String, completion: @escaping (UserId?, AuthenticationError?) -> Void)
    
}
