//  Created by Alessandro Comparini on 08/12/23.
//

import Foundation

public struct ClientModel {
    public var id: Int?
    public var name: String?
    public var cellPhone: String?
    public var cpf: String?
    public var email: String?
    public var birthDate: String?
    public var address: AddressModel?
   
    public init(id: Int? = nil, name: String? = nil, cellPhone: String? = nil, cpf: String? = nil, email: String? = nil, birthDate: String? = nil, address: AddressModel? = nil) {
        self.id = id
        self.name = name
        self.cellPhone = cellPhone
        self.cpf = cpf
        self.email = email
        self.birthDate = birthDate
        self.address = address
    }
    
}
