//  Created by Alessandro Comparini on 15/09/23.
//

import Foundation


public protocol SignUpPresenter {
    var outputDelegate: SignUpPresenterOutput? { get set }
    func createLogin(email: String, password: String, passwordConfirmation: String)
}
