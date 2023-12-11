//  Created by Alessandro Comparini on 10/12/23.
//

import Foundation
import CoreData
import HomeUseCaseGateway
import DataStorageSDKMain

public class CoreDataCreateScheduleRepositoryImpl: CreateScheduleRepository {
    
    private let dataStorage: DataStorageProviderStrategy
    private let context: NSManagedObjectContext
    
    public init(dataStorage: DataStorageProviderStrategy, context: NSManagedObjectContext) {
        self.dataStorage = dataStorage
        self.context = context
    }

    public func create(_ schedule: ScheduleGatewayDTO) async throws {
        let repository: CDSchedule = mapperToRepository(schedule)
        _ = try await dataStorage.create(repository)
    }

    
//  MARK: - PRIVATE AREA
    private func mapperToRepository(_ schedule: ScheduleGatewayDTO) -> CDSchedule {
        let repository = CDSchedule(context: context)
        repository.id = UUID()
        repository.address = schedule.address
        repository.clientID = Int32(schedule.clientID ?? 0)
        repository.clientName = schedule.clientName
        repository.serviceID = Int32(schedule.serviceID ?? 0)
        repository.serviceName = schedule.serviceName
        repository.dateInitialSchedule = schedule.dateInitialSchedule
        repository.dateFinalSchedule = schedule.dateFinalSchedule
        return repository
    }
    
}
