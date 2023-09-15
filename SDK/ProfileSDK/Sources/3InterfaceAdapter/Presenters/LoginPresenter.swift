
//  Created by Alessandro Comparini on 30/08/23.
//

import Foundation

public protocol LoginPresenter {
    var outputDelegate: LoginPresenterOutput? { get set }
    func login(email: String, password: String)
}
