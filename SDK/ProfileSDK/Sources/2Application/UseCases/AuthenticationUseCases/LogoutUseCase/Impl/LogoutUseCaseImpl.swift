//  Created by Alessandro Comparini on 01/11/23.
//

import Foundation

public class LogoutUseCaseImpl: LogoutUseCase {

    private let logoutGateway: LogoutUseCaseGateway
    
    public init(logoutGateway: LogoutUseCaseGateway) {
        self.logoutGateway = logoutGateway
    }
    
    public func logout() throws {
        try logoutGateway.logout()
    }

    
}
