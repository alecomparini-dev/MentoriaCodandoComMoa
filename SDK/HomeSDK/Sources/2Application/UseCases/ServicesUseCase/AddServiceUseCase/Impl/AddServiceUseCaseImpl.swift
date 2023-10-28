//  Created by Alessandro Comparini on 28/10/23.
//

import Foundation


public class AddServiceUseCaseImpl: AddServiceUseCase {
    private let addServiceUseCaseGateway: AddServiceUseCaseGateway
    
    public init(addServiceUseCaseGateway: AddServiceUseCaseGateway) {
        self.addServiceUseCaseGateway = addServiceUseCaseGateway
    }
    
    public func add(_ serviceUseCaseDTO: ServiceUseCaseDTO) async throws -> ServiceUseCaseDTO? {
        return try await addServiceUseCaseGateway.add(serviceUseCaseDTO)
    }
    

}
