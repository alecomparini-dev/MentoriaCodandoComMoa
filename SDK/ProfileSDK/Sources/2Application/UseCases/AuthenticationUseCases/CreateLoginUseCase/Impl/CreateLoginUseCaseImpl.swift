//  Created by Alessandro Comparini on 15/09/23.
//

import Foundation


public class CreateLoginUseCaseImpl: CreateLoginUseCase {
    private let createLoginUseCaseGateway: CreateLoginUseCaseGateway
    
    public init(createLoginUseCaseGateway: CreateLoginUseCaseGateway) {
        self.createLoginUseCaseGateway = createLoginUseCaseGateway
    }
    
    public func createLogin(email: String, password: String) async throws -> UserId {
        return try await createLoginUseCaseGateway.createLogin(email: email, password: password)
    }
    
}
