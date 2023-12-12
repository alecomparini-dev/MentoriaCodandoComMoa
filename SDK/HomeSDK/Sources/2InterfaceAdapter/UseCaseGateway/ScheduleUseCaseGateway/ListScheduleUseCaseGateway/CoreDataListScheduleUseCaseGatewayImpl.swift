//  Created by Alessandro Comparini on 11/12/23.
//

import Foundation

import HomeUseCases

public class CoreDataListScheduleUseCaseGatewayImpl: ListScheduleUseCaseGateway {
    
    private var fetchRepository: FetchScheduleRepository
    
    public init(fetchRepository: FetchScheduleRepository) {
        self.fetchRepository = fetchRepository
    }
    
    public func list() async throws -> [ScheduleUseCaseDTO] {
        let scheduleGatewayDTO: [ScheduleGatewayDTO] = try await fetchRepository.fetch()
        
        return scheduleGatewayDTO.map { schedule in
            ScheduleUseCaseDTO(
                id: schedule.id,
                address: schedule.address,
                clientID: schedule.clientID,
                clientName: schedule.clientName,
                serviceID: schedule.serviceID,
                serviceName: schedule.serviceName,
                dateInitialSchedule: schedule.dateInitialSchedule,
                dateFinalSchedule: schedule.dateFinalSchedule)
        }
    }
        
}
