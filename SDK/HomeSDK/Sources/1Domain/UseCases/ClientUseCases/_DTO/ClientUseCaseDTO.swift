//  Created by Alessandro Comparini on 08/12/23.
//

import Foundation

public struct ClientUseCaseDTO {
    public var id: Int?
    public var name: String?
    public var street: String?
    public var number: String?
    public var neighborhood: String?
    public var complement: String?
    
    public init(id: Int? = nil, name: String? = nil, street: String? = nil, number: String? = nil, neighborhood: String? = nil, complement: String? = nil) {
        self.id = id
        self.name = name
        self.street = street
        self.number = number
        self.neighborhood = neighborhood
        self.complement = complement
    }
    
}
