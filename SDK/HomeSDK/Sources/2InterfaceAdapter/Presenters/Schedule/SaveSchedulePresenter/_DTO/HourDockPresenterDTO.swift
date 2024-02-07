//  Created by Alessandro Comparini on 06/12/23.
//

import Foundation

public struct HourDockPresenterDTO {
    
    public var hour: String?
    public var minute: String?
    public var disabled: Bool
    
    public init(hour: String? = nil, minute: String? = nil, disabled: Bool) {
        self.hour = hour
        self.minute = minute
        self.disabled = disabled
    }
    
}
