//  Created by Alessandro Comparini on 20/10/23.
//

import Foundation

// MARK: - Result
public struct ResultCodable: Codable {
    public var name: String?
    public var image: String?
    public var phone: String?
    public var cpf: String?
    public var typeOfActivity: String?
    public var birthdate: String?
    public var cep: String?
    public var street: String?
    public var number: String?
    public var district: String?
    public var city: String?
    public var state: String?
    public var id: Int?
    public var isInativo: Bool?
    public var creationDate: String?
    public var changeDate: String?
    public var uid: String?
    public var uidFirebase: String?
    public var isChanged: Bool?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case image = "Image"
        case phone = "Phone"
        case cpf = "Cpf"
        case typeOfActivity = "TypeOfActivity"
        case birthdate = "Birthdate"
        case cep = "Cep"
        case street = "Street"
        case number = "Number"
        case district = "District"
        case city = "City"
        case state = "State"
        case id = "Id"
        case isInativo = "IsInativo"
        case creationDate = "CreationDate"
        case changeDate = "ChangeDate"
        case uid = "Uid"
        case uidFirebase = "UidFirebase"
        case isChanged = "IsChanged"
    }

    public init(name: String? = nil,
                image: String? = nil,
                phone: String? = nil,
                cpf: String? = nil,
                typeOfActivity: String? = nil,
                birthdate: String? = nil,
                cep: String? = nil,
                street: String? = nil,
                number: String? = nil,
                district: String? = nil,
                city: String? = nil,
                state: String? = nil,
                id: Int? = nil,
                isInativo: Bool? = nil,
                creationDate: String? = nil,
                changeDate: String? = nil,
                uid: String? = nil,
                uidFirebase: String? = nil,
                isChanged: Bool? = nil) {
        self.name = name
        self.image = image
        self.phone = phone
        self.cpf = cpf
        self.typeOfActivity = typeOfActivity
        self.birthdate = birthdate
        self.cep = cep
        self.street = street
        self.number = number
        self.district = district
        self.city = city
        self.state = state
        self.id = id
        self.isInativo = isInativo
        self.creationDate = creationDate
        self.changeDate = changeDate
        self.uid = uid
        self.uidFirebase = uidFirebase
        self.isChanged = isChanged
    }
}
