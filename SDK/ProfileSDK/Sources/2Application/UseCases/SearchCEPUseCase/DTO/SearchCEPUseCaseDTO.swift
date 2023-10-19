//  Created by Alessandro Comparini on 14/10/23.
//

import Foundation

public enum SearchCEPUseCaseDTO {
    
    public struct Input { }
    
    public struct Output {
        public let CEP: String
        public let street: String
        public let neighborhood: String
        public let city: String
        public let stateShortname: String
        public let state: String?
        
        public init(CEP: String, street: String, neighborhood: String, city: String, stateShortname: String, state: String?) {
            self.CEP = CEP
            self.street = street
            self.neighborhood = neighborhood
            self.city = city
            self.stateShortname = stateShortname
            self.state = state
        }
    }
        
}
