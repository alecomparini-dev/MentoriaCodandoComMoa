//  Created by Alessandro Comparini on 06/12/23.
//

import Foundation

public struct DateDockPresenterDTO {
    public var day: String?
    public var month: String?
    public var year: String?
    public var dayWeek: String?
    public var disabled: Bool
    
    public init(day: String? = nil, month: String? = nil, year: String? = nil, dayWeek: String? = nil, disabled: Bool) {
        self.day = day
        self.month = month
        self.year = year
        self.dayWeek = dayWeek
        self.disabled = disabled
    }
    
}
