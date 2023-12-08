//  Created by Alessandro Comparini on 07/12/23.
//

import Foundation

public struct ServicesPickerPresenterDTO {
    public var id: Int?
    public var name: String?
    public var duration: Int?
    
    public init(id: Int? = nil, name: String? = nil, duration: Int? = nil) {
        self.id = id
        self.name = name
        self.duration = duration
    }
    
}
