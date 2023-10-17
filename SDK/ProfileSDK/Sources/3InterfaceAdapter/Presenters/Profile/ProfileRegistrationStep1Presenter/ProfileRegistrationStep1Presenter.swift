//  Created by Alessandro Comparini on 16/10/23.
//

import Foundation

public protocol ProfileRegistrationStep1Presenter {
    var outputDelegate: ProfileRegistrationStep1PresenterOutput? { get set }
    func continueRegistrationStep2(_ profileRegistrationStep1DTO: ProfileRegistrationStep1DTO )
}
