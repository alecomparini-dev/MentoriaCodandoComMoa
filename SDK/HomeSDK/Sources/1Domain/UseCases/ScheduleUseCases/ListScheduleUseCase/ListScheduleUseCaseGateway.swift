//  Created by Alessandro Comparini on 11/12/23.
//

import Foundation

public protocol ListScheduleUseCaseGateway {
    func list() async throws -> [ScheduleUseCaseDTO]
}
