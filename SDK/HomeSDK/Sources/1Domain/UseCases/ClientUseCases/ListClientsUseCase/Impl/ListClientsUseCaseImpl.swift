//  Created by Alessandro Comparini on 08/12/23.
//

import Foundation


public class ListClientsUseCaseImpl: ListClientsUseCase {
    
    private let listClientGateway: ListClientsUseCaseGateway
    
    public init(listClientGateway: ListClientsUseCaseGateway) {
        self.listClientGateway = listClientGateway
    }
    
    public func list(_ userIDAuth: String) async throws -> [ClientUseCaseDTO] {
        let clientModel = try await listClientGateway.list(userIDAuth)
        
        return clientModel.map { client in
            ClientUseCaseDTO(id: client.id,
                             name: client.name,
                             street: client.address?.street,
                             number: client.address?.number?.description,
                             neighborhood: client.address?.neighborhood,
                             complement: client.address?.complement
            )
        }
    }
    
}
