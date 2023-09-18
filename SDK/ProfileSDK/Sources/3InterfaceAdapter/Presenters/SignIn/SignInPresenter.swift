
//  Created by Alessandro Comparini on 30/08/23.
//

import Foundation

public protocol SignInPresenter {
    var outputDelegate: SignInPresenterOutput? { get set }
    func login(email: String, password: String)
}
