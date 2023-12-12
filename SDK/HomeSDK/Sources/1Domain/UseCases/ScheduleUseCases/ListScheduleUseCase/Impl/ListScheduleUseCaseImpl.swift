//  Created by Alessandro Comparini on 11/12/23.
//

import Foundation

public class ListScheduleUseCaseImpl: ListScheduleUseCase {
    
    private let listScheduleGateway: ListScheduleUseCaseGateway
    
    public init(listScheduleGateway: ListScheduleUseCaseGateway) {
        self.listScheduleGateway = listScheduleGateway
    }
    
    //TODO: Includ userID
    public func list() async throws -> [ScheduleUseCaseDTO] {
        return try await listScheduleGateway.list()
    }
    
}
