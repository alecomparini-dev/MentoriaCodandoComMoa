//  Created by Alessandro Comparini on 10/12/23.
//

import Foundation
import HomeUseCaseGateway
import DataStorageDetail

public class CreateScheduleRepositoryImpl: CreateScheduleRepository {
    
    private var dataStorage: DataStorageProviderStrategy
    
    public init(dataStorage: DataStorageProviderStrategy) {
        self.dataStorage = dataStorage
    }

    public func insert(_ schedule: ScheduleGatewayDTO) async throws {
        let repository: CDSchedule = mapperToRepository(schedule)
    }

    
//  MARK: - PRIVATE AREA
    private func mapperToRepository(_ schedule: ScheduleGatewayDTO) -> CDSchedule {
        
        let repository = CDSchedule()
        repository.id = UUID()
        repository.clientID = Int32(truncating: schedule.clientID ?? 0)
        repository.clientName = schedule.clientName
        repository.serviceID = Int32(truncating: schedule.serviceID ?? 0)
        repository.serviceName = schedule.serviceName
        repository.dateInitialSchedule = schedule.dateInitialSchedule
        repository.dateFinalSchedule = schedule.dateFinalSchedule
        return repository
    }
    
}
