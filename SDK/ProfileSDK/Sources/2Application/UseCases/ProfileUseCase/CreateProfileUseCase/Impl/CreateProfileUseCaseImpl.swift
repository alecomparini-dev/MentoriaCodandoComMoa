//  Created by Alessandro Comparini on 20/10/23.
//

import Foundation

public class CreateProfileUseCaseImpl: CreateProfileUseCase {
    
    
    private let createProfileUseCaseGateway: CreateProfileUseCaseGateway
    
    public init(createProfileUseCaseGateway: CreateProfileUseCaseGateway) {
        self.createProfileUseCaseGateway = createProfileUseCaseGateway
    }
    
    
    public func create(_ createProfileDTO: ProfileUseCaseDTO) async throws -> ProfileUseCaseDTO? {
        
        let profileUseCaseDTO = try await createProfileUseCaseGateway.create(createProfileDTO)
        
        return profileUseCaseDTO

    }
    
    
}
