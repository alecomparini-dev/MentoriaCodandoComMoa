//
//  LoginViewControllerFactory.swift
//  Mentoria
//
//  Created by Alessandro Comparini on 14/09/23.
//

import Foundation
import ProfileUI
import ProfilePresenters

class LoginViewControllerFactory {

    static func make() -> LoginViewController {
        let loginPresenter = LoginPresenterImpl(validations: [] )
        return LoginViewController(loginPresenter: loginPresenter)
    }
    
}
