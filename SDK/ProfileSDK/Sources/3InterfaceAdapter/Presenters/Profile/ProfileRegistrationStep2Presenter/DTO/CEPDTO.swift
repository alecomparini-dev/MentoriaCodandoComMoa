//  Created by Alessandro Comparini on 14/10/23.
//

import Foundation

public struct CEPDTO {
    public var CEP: String?
    public var street: String?
    public var neighborhood: String?
    public var city: String?
    public var stateShortname: String?
    public var state: String?
    
    public init(CEP: String? = nil, street: String? = nil, neighborhood: String? = nil, city: String? = nil, stateShortname: String? = nil, state: String? = nil) {
        self.CEP = CEP
        self.street = street
        self.neighborhood = neighborhood
        self.city = city
        self.stateShortname = stateShortname
        self.state = state
    }
    
}
