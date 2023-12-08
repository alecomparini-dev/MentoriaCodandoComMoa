//  Created by Alessandro Comparini on 08/12/23.
//

import Foundation
import HomeDomain

public typealias ClientsCodable = [ClientsCodableElement]

// MARK: - ClientsCodableElement
public struct ClientsCodableElement: Codable {
    public var name: String?
    public var phone: String?
    public var cpf: String?
    public var birthdate: String?
    public var cep: String?
    public var street: String?
    public var number: String?
    public var district: String?
    public var city: String?
    public var state: String?
    public var email: String?
    public var id: Int?
    public var isInativo: Bool?
    public var creationDate: String?
    public var changeDate: String?
    public var uid: String?
    public var uidFirebase: String?
    public var isChanged: Bool?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case phone = "Phone"
        case cpf = "Cpf"
        case birthdate = "Birthdate"
        case cep = "Cep"
        case street = "Street"
        case number = "Number"
        case district = "District"
        case city = "City"
        case state = "State"
        case email = "Email"
        case id = "Id"
        case isInativo = "IsInativo"
        case creationDate = "CreationDate"
        case changeDate = "ChangeDate"
        case uid = "Uid"
        case uidFirebase = "UidFirebase"
        case isChanged = "IsChanged"
    }

    public init(name: String? = nil, phone: String? = nil, cpf: String? = nil, birthdate: String? = nil, cep: String? = nil, street: String? = nil, number: String? = nil, district: String? = nil, city: String? = nil, state: String? = nil, email: String? = nil, id: Int? = nil, isInativo: Bool? = nil, creationDate: String? = nil, changeDate: String? = nil, uid: String? = nil, uidFirebase: String? = nil, isChanged: Bool? = nil) {
        self.name = name
        self.phone = phone
        self.cpf = cpf
        self.birthdate = birthdate
        self.cep = cep
        self.street = street
        self.number = number
        self.district = district
        self.city = city
        self.state = state
        self.email = email
        self.id = id
        self.isInativo = isInativo
        self.creationDate = creationDate
        self.changeDate = changeDate
        self.uid = uid
        self.uidFirebase = uidFirebase
        self.isChanged = isChanged
    }
    
}

//  MARK: - EXTENSION to MAPPER
extension ClientsCodable {
    
    func mapperToClientModel() -> [ClientModel] {
        
        return self.map { client in
            return ClientModel(
                id: client.id,
                name: client.name,
                cellPhone: client.phone,
                cpf: client.cpf,
                email: client.email,
                birthDate: client.birthdate,
                address: AddressModel(
                    cep: Int(client.cep ?? "0"),
                    street: client.street,
                    number: Int(client.number ?? "0"),
                    neighborhood: client.district,
                    city: client.city,
                    state: client.state
                )
            )
        }
        
    }
    
}


