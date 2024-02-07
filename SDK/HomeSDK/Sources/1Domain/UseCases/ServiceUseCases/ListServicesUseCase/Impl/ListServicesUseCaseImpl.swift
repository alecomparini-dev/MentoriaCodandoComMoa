//  Created by Alessandro Comparini on 23/10/23.
//

import Foundation

final public class ListServicesUseCaseImpl: ListServicesUseCase {

    private let listServicesGateway: ListServicesUseCaseGateway
    
    public init(listServicesGateway: ListServicesUseCaseGateway) {
        self.listServicesGateway = listServicesGateway
    }
    
    public func list(_ userIDAuth: String) async throws -> [ServiceUseCaseDTO]? {
        return try await listServicesGateway.list(userIDAuth)
    }
    
    
}
