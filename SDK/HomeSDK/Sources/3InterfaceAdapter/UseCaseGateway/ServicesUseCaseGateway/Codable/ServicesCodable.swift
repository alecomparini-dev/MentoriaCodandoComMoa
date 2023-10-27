//  Created by Alessandro Comparini on 26/10/23.
//

import Foundation

import HomeUseCases

public typealias ServicesCodable = [ServicesCodableElement]

public struct ServicesCodableElement: Codable {
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

    public init(name: String?, description: String?, duration: Int?, howMutch: Double?, id: Int?, isInativo: Bool?,
                creationDate: String?, changeDate: String?, uid: String?, uidFirebase: String?, isChanged: Bool?) {
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


extension ServicesCodable {
    
    func mapperToServiceDTO() -> [ServiceDTO] {
        
        return self.map { service in
            return ServiceDTO(
                uidFirebase: service.uidFirebase,
                id: service.id,
                name: service.name,
                description: service.description,
                duration: service.duration,
                howMutch: service.howMutch,
                uid: service.uid)
        }
        
    }
    
}
