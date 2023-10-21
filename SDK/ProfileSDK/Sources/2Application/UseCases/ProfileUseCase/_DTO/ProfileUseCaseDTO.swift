//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation

public struct ProfileUseCaseDTO {
    public var userIDAuth: String?
    public var userID: Int?
    public var name: String?
    public var image: String?
    public var cpf: String?
    public var cellPhone: String?
    public var fieldOfWork: String?
    public var dateOfBirth: String?
    public var profileAddress: ProfileAddressUseCaseDTO?
    
    public init(userIDAuth: String? = nil, 
                userID: Int? = nil,
                name: String? = nil,
                image: String? = nil,
                cpf: String? = nil,
                phone: String? = nil,
                fieldOfWork: String? = nil,
                dateOfBirth: String? = nil,
                profileAddress: ProfileAddressUseCaseDTO? = nil) {
        self.userIDAuth = userIDAuth
        self.userID = userID
        self.name = name
        self.image = image
        self.cpf = cpf
        self.cellPhone = phone
        self.fieldOfWork = fieldOfWork
        self.dateOfBirth = dateOfBirth
        self.profileAddress = profileAddress
    }
    
    
    
}

