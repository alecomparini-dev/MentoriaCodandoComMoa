//  Created by Alessandro Comparini on 24/10/23.
//

import Foundation

public struct ServicePresenterDTO {
    public var id: Int?
    public var uIDFirebase: String?
    public var name: String?
    public var description: String?
    public var duration: String?
    public var howMutch: String?
    
    public init(id: Int? = nil, 
                uIDFirebase: String? = nil,
                name: String? = nil,
                description: String? = nil,
                duration: String? = nil,
                howMutch: String? = nil) {
        self.id = id
        self.uIDFirebase = uIDFirebase
        self.name = name
        self.description = description
        self.duration = duration
        self.howMutch = howMutch
    }
    
}
