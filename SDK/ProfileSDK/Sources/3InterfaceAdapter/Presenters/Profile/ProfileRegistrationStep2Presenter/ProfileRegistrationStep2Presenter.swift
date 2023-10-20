//  Created by Alessandro Comparini on 14/10/23.
//

import Foundation

public protocol ProfileRegistrationStep2Presenter {
    var outputDelegate: ProfileRegistrationStep2PresenterOutput? { get set }
    func searchCep(_ cep: String)
    func createProfile(_ profileDTO: ProfilePresenterDTO)
    func setCEPMaskWithRange(_ range: NSRange, _ string: String) -> String?
}
