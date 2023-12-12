//  Created by Alessandro Comparini on 10/12/23.
//

import Foundation

import CoreData
import HomeUseCaseGateway
import DataStorageSDKMain

public class CoreDataFetchScheduleRepositoryImpl: FetchScheduleRepository {
    private let dataStorage: DataStorageProviderStrategy
    private let context: NSManagedObjectContext
    
    public init(dataStorage: DataStorageProviderStrategy, context: NSManagedObjectContext) {
        self.dataStorage = dataStorage
        self.context = context
    }
    
    public func fetch() async throws -> [ScheduleGatewayDTO] {
        let cdSchedules: [CDSchedule] = try await dataStorage.fetch()
        
        let listSchedule = cdSchedules.map({ cdSchedule in
            return ScheduleGatewayDTO(
                id: UUID(uuidString: cdSchedule.id ?? "") ,
                address: cdSchedule.address,
                clientID: Int(cdSchedule.clientID),
                clientName: cdSchedule.clientName,
                serviceID: Int(cdSchedule.serviceID),
                serviceName: cdSchedule.serviceName,
                dateInitialSchedule: cdSchedule.dateInitialSchedule,
                dateFinalSchedule: cdSchedule.dateFinalSchedule)
        })
        
        return listSchedule
    }
    
    
}
