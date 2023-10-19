//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation

public class GetProfileUseCaseImpl: GetProfileUseCase {
    
    private let getProfileUseCaseGateway: GetProfileUseCaseGateway
    
    public init(getProfileUseCaseGateway: GetProfileUseCaseGateway) {
        self.getProfileUseCaseGateway = getProfileUseCaseGateway
    }
    
    public func getProfile(_ userIDAuth: String) async throws {
        let profile = try await getProfileUseCaseGateway.getProfile(userIDAuth)
        
        print(profile ?? "")
    }
 
}
