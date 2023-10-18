//  Created by Alessandro Comparini on 17/10/23.
//

import Foundation

public struct ProfileAddressPresenterDTO {
    public var cep: String?
    public var street: String?
    public var number: String?
    public var neighborhood: String?
    public var city: String?
    public var state: String?
    
    public init(cep: String? = nil, street: String? = nil, number: String? = nil,
                neighborhood: String? = nil, city: String? = nil, state: String? = nil) {
        self.cep = cep
        self.street = street
        self.number = number
        self.neighborhood = neighborhood
        self.city = city
        self.state = state
    }
}
