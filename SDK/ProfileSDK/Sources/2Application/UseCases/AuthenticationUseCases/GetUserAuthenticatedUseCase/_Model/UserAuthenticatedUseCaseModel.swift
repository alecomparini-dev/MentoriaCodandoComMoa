//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation

public struct UserAuthenticatedUseCaseModel {
    public let userIDAuth: String
    public let email: String?
    public let phoneNumber: String?
    public var isEmailVerified: Bool?
    public var displayName: String?
    public var photoURL: String?
    
    public init(userIDAuth: String, 
                email: String? = nil,
                phoneNumber: String? = nil,
                isEmailVerified: Bool? = nil,
                displayName: String? = nil,
                photoURL: String? = nil) {
        self.userIDAuth = userIDAuth
        self.email = email
        self.phoneNumber = phoneNumber
        self.isEmailVerified = isEmailVerified
        self.displayName = displayName
        self.photoURL = photoURL
    }
}
