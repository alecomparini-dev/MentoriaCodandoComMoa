//  Created by Alessandro Comparini on 23/10/23.
//

import Foundation

public struct ServiceUseCaseDTO {
    public var uidFirebase: String?
    public var id: Int?
    public var name: String?
    public var description: String?
    public var duration: Int?
    public var howMutch: Double?
    public var uid: String?
    
    public init(uidFirebase: String? = nil, 
                id: Int? = nil,
                name: String? = nil, 
                description: String? = nil,
                duration: Int? = nil,
                howMutch: Double? = nil,
                uid: String? = nil) {
        self.uidFirebase = uidFirebase
        self.id = id
        self.name = name
        self.description = description
        self.duration = duration
        self.howMutch = howMutch
        self.uid = uid
    }
}
