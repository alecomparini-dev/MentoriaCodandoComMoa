//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation

public struct ProfileUseCaseModel {
    public var userIDAuth: String?
    public var userID: Int?
    public var name: String?
    public var image: Data?
    public var cpf: String?
    public var phone: String?
    public var fieldOfWork: String?
    public var dateOfBirth: String?
    public var profileAddress: ProfileAddressUseCaseModel?
    
    public init(userIDAuth: String? = nil, 
                userID: Int? = nil,
                name: String? = nil,
                image: Data? = nil,
                cpf: String? = nil,
                phone: String? = nil,
                fieldOfWork: String? = nil,
                dateOfBirth: String? = nil,
                profileAddress: ProfileAddressUseCaseModel? = nil) {
        self.userIDAuth = userIDAuth
        self.userID = userID
        self.name = name
        self.image = image
        self.cpf = cpf
        self.phone = phone
        self.fieldOfWork = fieldOfWork
        self.dateOfBirth = dateOfBirth
        self.profileAddress = profileAddress
    }
    
}

