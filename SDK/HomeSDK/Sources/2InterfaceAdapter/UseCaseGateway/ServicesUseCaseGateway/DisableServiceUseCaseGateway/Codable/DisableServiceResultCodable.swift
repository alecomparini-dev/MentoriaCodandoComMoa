//  Created by Alessandro Comparini on 27/10/23.
//

import Foundation

public struct DisableServiceResultCodable: Codable {
    public var name: String?
    public var description: String?
    public var duration: Int?
    public var howMutch: Double?
    public var id: Int?
    public var isInativo: Bool?
    public var creationDate: String?
    public var changeDate: String?
    public var uid: String?
    public var uidFirebase: String?
    public var isChanged: Bool?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case description = "Description"
        case duration = "Duration"
        case howMutch = "HowMutch"
        case id = "Id"
        case isInativo = "IsInativo"
        case creationDate = "CreationDate"
        case changeDate = "ChangeDate"
        case uid = "Uid"
        case uidFirebase = "UidFirebase"
        case isChanged = "IsChanged"
    }

    public init(name: String? = nil, description: String? = nil, 
                duration: Int? = nil, howMutch: Double? = nil,
                id: Int? = nil, isInativo: Bool? = nil, creationDate: String? = nil, changeDate: String? = nil, uid: String? = nil, uidFirebase: String? = nil, isChanged: Bool? = nil) {
        self.name = name
        self.description = description
        self.duration = duration
        self.howMutch = howMutch
        self.id = id
        self.isInativo = isInativo
        self.creationDate = creationDate
        self.changeDate = changeDate
        self.uid = uid
        self.uidFirebase = uidFirebase
        self.isChanged = isChanged
    }
}
