//  Created by Alessandro Comparini on 19/10/23.
//

import Foundation

public struct GetProfileUseCaseDTO {
    
    public struct Output {
        public var userIDAuth: String?
        public var userIDProfile: Int?
        public var imageProfile: String?
        public var name: String?
        public var cpf: String?
        public var dateOfBirth: String?
        public var cellPhoneNumber: String?
        public var fieldOfWork: String?
        public var cep: String?
        public var street: String?
        public var number: String?
        public var neighborhood: String?
        public var city: String?
        public var state: String?
        public var complement: String?
        
        public init(userIDAuth: String? = nil,
                    userIDProfile: Int? = nil,
                    imageProfile: String? = nil,
                    name: String? = nil,
                    cpf: String? = nil,
                    dateOfBirth: String? = nil,
                    cellPhoneNumber: String? = nil,
                    fieldOfWork: String? = nil,
                    cep: String? = nil,
                    street: String? = nil,
                    number: String? = nil,
                    neighborhood: String? = nil, 
                    city: String? = nil,
                    state: String? = nil,
                    complement: String? = nil) {
            self.userIDAuth = userIDAuth
            self.userIDProfile = userIDProfile
            self.imageProfile = imageProfile
            self.name = name
            self.cpf = cpf
            self.dateOfBirth = dateOfBirth
            self.cellPhoneNumber = cellPhoneNumber
            self.fieldOfWork = fieldOfWork
            self.cep = cep
            self.street = street
            self.number = number
            self.neighborhood = neighborhood
            self.city = city
            self.state = state
            self.complement = complement
        }
    }
    
}


