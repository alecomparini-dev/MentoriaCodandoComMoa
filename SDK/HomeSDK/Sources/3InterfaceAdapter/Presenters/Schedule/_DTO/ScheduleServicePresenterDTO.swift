//  Created by Alessandro Comparini on 01/12/23.
//

import Foundation

public struct ScheduleServicePresenterDTO {
    public var id: Int?
    public var name: String?
    public var duration: String?
    public var howMutch: String?
    
    public init(id: Int? = nil, name: String? = nil, duration: String? = nil, howMutch: String? = nil) {
        self.id = id
        self.name = name
        self.duration = duration
        self.howMutch = howMutch
    }
}
