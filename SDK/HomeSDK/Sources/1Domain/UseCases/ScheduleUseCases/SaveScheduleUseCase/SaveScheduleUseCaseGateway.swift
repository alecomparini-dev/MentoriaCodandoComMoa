//  Created by Alessandro Comparini on 09/12/23.
//

import Foundation

public protocol SaveScheduleUseCaseGateway {
    func save(_ schedule: ScheduleUseCaseDTO) async throws
}
