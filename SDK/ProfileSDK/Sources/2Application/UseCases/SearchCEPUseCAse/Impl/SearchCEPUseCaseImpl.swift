//  Created by Alessandro Comparini on 14/10/23.
//

import Foundation

public class SearchCEPUseCaseImpl: SearchCEPUseCase {
    
    private let searchCEPGateway: SearchCEPUseCaseGateway
    
    public init(searchCEPGateway: SearchCEPUseCaseGateway) {
        self.searchCEPGateway = searchCEPGateway
    }
    
    public func get(_ cep: String) async throws -> SearchCEPUseCaseDTO.Output? {
        
        guard let cep = Int(cep.replacingOccurrences(of: "-", with: "")) else {return nil}
        
        return try await searchCEPGateway.get(cep)
    }
    
}
