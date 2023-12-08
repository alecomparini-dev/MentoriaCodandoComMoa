//  Created by Alessandro Comparini on 08/12/23.
//

import Foundation

public struct ClientUseCaseDTO {
    public var id: Int?
    public var name: String?
    
    public init(id: Int? = nil, name: String? = nil) {
        self.id = id
        self.name = name
    }
    
}
