//  Created by Alessandro Comparini on 09/12/23.
//

import Foundation

import HomeUseCases
import CoreData

public class CoreDataSaveScheduleUseCaseGatewayImpl: SaveScheduleUseCaseGateway {

    private var createRepository: CreateScheduleRepository
    
    public init(createRepository: CreateScheduleRepository) {
        self.createRepository = createRepository
    }

    public func save(_ scheduleUseCaseDTO: ScheduleUseCaseDTO) async throws {
        let scheduleGatewayDTO = ScheduleUseCaseDTOMapper().toScheduleGatewayDTO(scheduleUseCaseDTO)
        try await createRepository.create(scheduleGatewayDTO)
    }
    

    
}
