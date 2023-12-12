//  Created by Alessandro Comparini on 09/12/23.
//

import Foundation

public class SaveScheduleUseCaseImpl: SaveScheduleUseCase {
    
    
    private let saveScheduleGateway: SaveScheduleUseCaseGateway
    
    public init(saveScheduleGateway: SaveScheduleUseCaseGateway) {
        self.saveScheduleGateway = saveScheduleGateway
    }
    
    public func save(_ schedule: ScheduleUseCaseDTO) async throws {
        return try await saveScheduleGateway.save(schedule)
    }

    
}
