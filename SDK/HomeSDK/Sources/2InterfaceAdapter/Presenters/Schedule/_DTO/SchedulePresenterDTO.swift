//  Created by Alessandro Comparini on 01/12/23.
//

import Foundation

public struct SchedulePresenterDTO {
    public var id: String?
    public var date: String?
    public var hour: String?
    public var min: String?
    public var service: ScheduleServicePresenterDTO?
    public var client: ScheduleClientPresenterDTO?
    
    public init(id: String? = nil, date: String? = nil, hour: String? = nil, min: String? = nil, service: ScheduleServicePresenterDTO? = nil, client: ScheduleClientPresenterDTO? = nil) {
        self.id = id
        self.date = date
        self.hour = hour
        self.min = min
        self.service = service
        self.client = client
    }
    
}

public struct SectionSchedules {
    public var dateControl: String
    public var dayTitle: String
    public var monthTitle: String
    public var dayWeekNameTitle: String
    public var rows: [RowsSchedules]
}

public struct RowsSchedules {
    public var schedule: SchedulePresenterDTO?
}
