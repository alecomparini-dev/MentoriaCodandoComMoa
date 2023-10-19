//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation

public struct Address {
    public var cep: String
    public var street: String
    public var number: String
    public var complement: String?
    public var neighborhood: String
    public var city: String
    public var state: String
    
    public init(cep: String, street: String, number: String, complement: String? = nil, neighborhood: String, city: String, state: String) {
        self.cep = cep
        self.street = street
        self.number = number
        self.complement = complement
        self.neighborhood = neighborhood
        self.city = city
        self.state = state
    }
}
