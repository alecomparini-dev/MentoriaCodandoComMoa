//  Created by Alessandro Comparini on 08/12/23.
//

import Foundation

public struct AddressModel {
    public var cep: Int?
    public var street: String?
    public var number: Int?
    public var complement: String?
    public var neighborhood: String?
    public var city: String?
    public var state: String?
    
    public init(cep: Int? = nil, street: String? = nil, number: Int? = nil, complement: String? = nil, neighborhood: String? = nil, city: String? = nil, state: String? = nil) {
        self.cep = cep
        self.street = street
        self.number = number
        self.complement = complement
        self.neighborhood = neighborhood
        self.city = city
        self.state = state
    }
    
}
