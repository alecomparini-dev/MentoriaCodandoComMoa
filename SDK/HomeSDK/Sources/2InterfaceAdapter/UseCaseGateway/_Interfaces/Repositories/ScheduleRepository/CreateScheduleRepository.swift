//  Created by Alessandro Comparini on 10/12/23.
//

import Foundation

public protocol CreateScheduleRepository {
    func create(_ schedule: ScheduleGatewayDTO) async throws
}
