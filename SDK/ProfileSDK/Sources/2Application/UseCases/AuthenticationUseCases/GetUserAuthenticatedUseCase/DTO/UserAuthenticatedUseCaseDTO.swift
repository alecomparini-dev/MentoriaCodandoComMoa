//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation

public struct UserAuthenticatedUseCaseDTO {
    
    public struct Input {
        
    }
    
    public struct Output {
        public let userIDAuth: String
        public let email: String?
        public var phoneNumber: String?
        public var displayName: String?
        public var imageProfile: Data?
        
        public init(userIDAuth: String,
                    email: String? = nil,
                    phoneNumber: String? = nil,
                    displayName: String? = nil,
                    imageProfile: Data? = nil) {
            self.userIDAuth = userIDAuth
            self.email = email
            self.phoneNumber = phoneNumber
            self.displayName = displayName
            self.imageProfile = imageProfile
        }
        
    }
    
}
