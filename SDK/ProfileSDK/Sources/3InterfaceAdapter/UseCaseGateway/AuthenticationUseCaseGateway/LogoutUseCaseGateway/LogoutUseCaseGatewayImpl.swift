//  Created by Alessandro Comparini on 01/11/23.
//

import Foundation

import ProfileUseCases

public class LogoutUseCaseGatewayImpl: LogoutUseCaseGateway {
    
    private let logoutAuth: Logout
    
    public init(logoutAuth: Logout) {
        self.logoutAuth = logoutAuth
    }
    
    public func logout() throws {
        try logoutAuth.logout()
    }
    
}
