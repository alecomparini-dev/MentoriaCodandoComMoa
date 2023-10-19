//  Created by Alessandro Comparini on 16/10/23.
//


import Foundation
import ProfileUI
import ProfilePresenters
import ProfileValidations



class ProfileRegistrationStep1Factory {
    
    static func make() -> ProfileRegistrationStep1ViewController {
        
        let validations = Validations()
        
        let profileStep1Presenter = ProfileRegistrationStep1PresenterImpl(cpfValidator: validations)
        
        return ProfileRegistrationStep1ViewController(profileStep1Presenter: profileStep1Presenter )
        
    }
    
}
