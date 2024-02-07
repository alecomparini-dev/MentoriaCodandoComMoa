//  Created by Alessandro Comparini on 16/10/23.
//

import Foundation

public protocol ProfileRegistrationStep1Presenter {
    var outputDelegate: ProfileRegistrationStep1PresenterOutput? { get set }
    func continueRegistrationStep2(_ profilePresenterDTO: ProfilePresenterDTO?)
    func setMaskWithRange(_ typeMask: TypeMasks, _ range: NSRange, _ string: String) -> String?
    func setMask(_ typeMask: TypeMasks, text: String ) -> String?
}

