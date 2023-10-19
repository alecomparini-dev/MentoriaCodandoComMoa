//  Created by Alessandro Comparini on 16/10/23.
//


import Foundation
import ProfileUI
import ProfilePresenters
import ProfileValidations


class ProfileRegistrationStep1Factory {
    
    static func make() -> ProfileRegistrationStep1ViewController {
        
        let validations = Validations()
        
        let masks: [TypeMasks: Masks] = makeMasks()
        
        let profileStep1Presenter = ProfileRegistrationStep1PresenterImpl(cpfValidator: validations, masks: masks)
        
        return ProfileRegistrationStep1ViewController(profileStep1Presenter: profileStep1Presenter )
        
    }
    
    static private func makeMasks() -> [TypeMasks: Masks] {
        var masks: [TypeMasks: Masks] = [:]
        masks.updateValue(CellPhoneMask(), forKey: TypeMasks.cellPhoneMask)
        masks.updateValue(CPFMask(), forKey: TypeMasks.CPFMask)
        masks.updateValue(CEPMask(), forKey: TypeMasks.dateMask)
        return masks
    }
    
}
