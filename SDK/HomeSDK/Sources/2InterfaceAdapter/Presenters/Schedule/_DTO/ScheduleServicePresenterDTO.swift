//  Created by Alessandro Comparini on 01/12/23.
//

import Foundation

public struct ScheduleServicePresenterDTO {
    public var id: Int?
    public var name: String?
    
    public init(id: Int? = nil, name: String? = nil) {
        self.id = id
        self.name = name
    }
}
