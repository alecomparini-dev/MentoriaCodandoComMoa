//  Created by Alessandro Comparini on 14/10/23.
//

import Foundation

public class SearchCEPUseCaseImpl: SearchCEPUseCase {
    
    private let searchCEPGateway: SearchCEPUseCaseGateway
    
    public init(searchCEPGateway: SearchCEPUseCaseGateway) {
        self.searchCEPGateway = searchCEPGateway
    }
    
    public func get(_ cep: String) async throws -> SearchCEPUseCaseDTO.Output? {
        
        let cepWithOutMask = cep.replacingOccurrences(of: "-", with: "")
        
        return try await searchCEPGateway.get(cepWithOutMask)
    }
    
}
