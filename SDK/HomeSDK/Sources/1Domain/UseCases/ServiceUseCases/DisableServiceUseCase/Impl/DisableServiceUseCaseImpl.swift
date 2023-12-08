//  Created by Alessandro Comparini on 27/10/23.
//

import Foundation

public class DisableServiceUseCaseImpl: DisableServiceUseCase {
    
    private let disableServiceUseCaseGateway: DisableServiceUseCaseGateway
    
    public init(disableServiceUseCaseGateway: DisableServiceUseCaseGateway) {
        self.disableServiceUseCaseGateway = disableServiceUseCaseGateway
    }
    
    
    public func disable(_ idService: Int, _ userIDAuth: String) async throws -> Bool {
        return try await disableServiceUseCaseGateway.disable(idService, userIDAuth)
    }
    
}
