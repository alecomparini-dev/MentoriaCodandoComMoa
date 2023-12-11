//  Created by Alessandro Comparini on 09/12/23.
//

import Foundation

import HomeUseCases
import CoreData

public class CoreDataSaveScheduleUseCaseGatewayImpl: SaveScheduleUseCaseGateway {

    private var repository: CreateScheduleRepository
    
    public init(repository: CreateScheduleRepository) {
        self.repository = repository
    }

    public func save(_ scheduleUseCaseDTO: ScheduleUseCaseDTO) async throws {
        let scheduleGatewayDTO = ScheduleUseCaseDTOMapper().toScheduleGatewayDTO(scheduleUseCaseDTO)
        try await repository.create(scheduleGatewayDTO)
    }
    

    
}
