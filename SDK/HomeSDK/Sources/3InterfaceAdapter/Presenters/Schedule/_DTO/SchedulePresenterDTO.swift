//  Created by Alessandro Comparini on 01/12/23.
//

import Foundation

public struct SchedulePresenterDTO {
    public var date: String?
    public var time: String?
    public var service: ScheduleServicePresenterDTO?
    public var client: ScheduleClientPresenterDTO?
    
    public init(date: String? = nil, time: String? = nil, service: ScheduleServicePresenterDTO? = nil, client: ScheduleClientPresenterDTO? = nil) {
        self.date = date
        self.time = time
        self.service = service
        self.client = client
    }
    
}

