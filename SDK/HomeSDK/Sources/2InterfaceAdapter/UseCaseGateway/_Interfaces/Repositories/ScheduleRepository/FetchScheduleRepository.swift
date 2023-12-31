//  Created by Alessandro Comparini on 11/12/23.
//

import Foundation

public protocol FetchScheduleRepository {
    func fetch() async throws -> [ScheduleGatewayDTO]
}
