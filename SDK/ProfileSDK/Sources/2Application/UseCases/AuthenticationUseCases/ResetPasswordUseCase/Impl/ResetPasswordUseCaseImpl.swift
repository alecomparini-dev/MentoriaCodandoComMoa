//  Created by Alessandro Comparini on 31/10/23.
//

import Foundation

public class ResetPasswordUseCaseImpl: ResetPasswordUseCase {

    private let resetPasswordGateway: ResetPasswordUseCaseGateway
    
    public init(resetPasswordGateway: ResetPasswordUseCaseGateway) {
        self.resetPasswordGateway = resetPasswordGateway
    }
    
    public func reset(userEmail: String) async -> Bool {
        return await resetPasswordGateway.reset(userEmail: userEmail)
    }
    
}
