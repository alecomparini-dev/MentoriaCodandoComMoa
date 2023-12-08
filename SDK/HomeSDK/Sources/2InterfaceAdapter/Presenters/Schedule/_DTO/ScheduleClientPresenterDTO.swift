//  Created by Alessandro Comparini on 01/12/23.
//

import Foundation

public struct ScheduleClientPresenterDTO {
    public var id: String?
    public var name: String?
    public var address: AddressPresenterDTO?
    
    public init(id: String? = nil, name: String? = nil, address: AddressPresenterDTO? = nil) {
        self.id = id
        self.name = name
        self.address = address
    }
}
