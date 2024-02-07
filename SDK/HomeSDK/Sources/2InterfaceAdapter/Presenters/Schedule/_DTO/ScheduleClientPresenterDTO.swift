//  Created by Alessandro Comparini on 01/12/23.
//

import Foundation

public struct ScheduleClientPresenterDTO {
    public var id: Int?
    public var name: String?
    public var address: String?
    
    public init(id: Int? = nil, name: String? = nil, address: String? = nil) {
        self.id = id
        self.name = name
        self.address = address
    }
}
