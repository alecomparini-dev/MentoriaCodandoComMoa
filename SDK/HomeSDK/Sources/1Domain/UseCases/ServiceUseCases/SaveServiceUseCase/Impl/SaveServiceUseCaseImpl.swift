//  Created by Alessandro Comparini on 28/10/23.
//

import Foundation


public class SaveServiceUseCaseImpl: SaveServiceUseCase {
    private let saveServiceUseCaseGateway: SaveServiceUseCaseGateway
    
    public init(saveServiceUseCaseGateway: SaveServiceUseCaseGateway) {
        self.saveServiceUseCaseGateway = saveServiceUseCaseGateway
    }
    
    public func save(_ serviceUseCaseDTO: ServiceUseCaseDTO) async throws -> ServiceUseCaseDTO? {
        return try await saveServiceUseCaseGateway.save(serviceUseCaseDTO)
    }
    

}
