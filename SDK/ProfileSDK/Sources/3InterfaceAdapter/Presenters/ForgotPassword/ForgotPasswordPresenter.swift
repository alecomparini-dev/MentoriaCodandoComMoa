//  Created by Alessandro Comparini on 31/10/23.
//

import Foundation

public protocol ForgotPasswordPresenter {
    var outputDelegate: ForgotPasswordPresenterOutput? { get set }
    func resetPassword(_ userEmail: String?)
}
