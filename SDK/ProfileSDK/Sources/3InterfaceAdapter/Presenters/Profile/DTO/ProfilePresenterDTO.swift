//  Created by Alessandro Comparini on 16/10/23.
//

import Foundation

public struct ProfilePresenterDTO {
    public var userIDAuth: String?
    public var userIDProfile: Int?
    public var imageProfile: String?
    public var imageDataProfile: Data?
    public var name: String?
    public var cpf: String?
    public var dateOfBirth: String?
    public var cellPhoneNumber: String?
    public var fieldOfWork: String?
    public var address: ProfileAddressPresenterDTO?
    
    public init(userIDAuth: String? = nil,
                userIDProfile: Int? = nil, 
                imageProfile: String? = nil,
                name: String? = nil, 
                cpf: String? = nil,
                dateOfBirth: String? = nil, 
                cellPhoneNumber: String? = nil, 
                fieldOfWork: String? = nil,
                address: ProfileAddressPresenterDTO? = nil) {
        self.userIDAuth = userIDAuth
        self.userIDProfile = userIDProfile
        self.imageProfile = imageProfile
        self.name = name
        self.cpf = cpf
        self.dateOfBirth = dateOfBirth
        self.cellPhoneNumber = cellPhoneNumber
        self.fieldOfWork = fieldOfWork
        self.address = address
    }
}
