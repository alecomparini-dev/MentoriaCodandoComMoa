//  Created by Alessandro Comparini on 01/12/23.
//

import Foundation

public struct SchedulePresenterDTO {
    public var id: String?
    public var date: String?
    public var hour: String?
    public var service: ScheduleServicePresenterDTO?
    public var client: ScheduleClientPresenterDTO?
    
    public init(id: String? = nil, date: String? = nil, hour: String? = nil, service: ScheduleServicePresenterDTO? = nil, client: ScheduleClientPresenterDTO? = nil) {
        self.id = id
        self.date = date
        self.hour = hour
        self.service = service
        self.client = client
    }
    
}

