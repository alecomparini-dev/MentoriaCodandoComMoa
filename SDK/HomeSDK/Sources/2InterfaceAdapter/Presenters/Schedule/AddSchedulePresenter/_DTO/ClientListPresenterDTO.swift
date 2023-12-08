//  Created by Alessandro Comparini on 07/12/23.
//

import Foundation

public struct ClientListPresenterDTO {
    public var id: Int?
    public var name: String?
    
    public init(id: Int? = nil, name: String? = nil) {
        self.id = id
        self.name = name
    }
    
}
