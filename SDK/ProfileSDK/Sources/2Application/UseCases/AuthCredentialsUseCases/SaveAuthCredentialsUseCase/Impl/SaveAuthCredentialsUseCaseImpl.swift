//  Created by Alessandro Comparini on 05/11/23.
//

import Foundation

public class SaveAuthCredentialsUseCaseImpl: SaveAuthCredentialsUseCase {
    private let saveAuthCredentialsGateway: SaveKeyChainUseCaseGateway
    
    public init(saveAuthCredentialsGateway: SaveKeyChainUseCaseGateway) {
        self.saveAuthCredentialsGateway = saveAuthCredentialsGateway
    }
    
    public func save(email: String, password: String) async throws -> Bool {
        do {
            try await saveAuthCredentialsGateway.save(forKey: ProfileUseCasesConstants.credentials, [email, password])
            return true
        } catch {
            return false
        }
    }
    
}
