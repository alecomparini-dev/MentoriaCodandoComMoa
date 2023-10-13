//
//  SignUpCoordinator.swift
//  Mentoria
//
//  Created by Alessandro Comparini on 14/09/23.
//

import Foundation

import ProfileUI

class SignUpCoordinator: Coordinator {
    var childCoordinator: Coordinator?
    
    unowned let navigationController: NavigationController
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        childCoordinator = self
        var controller = SignUpViewControllerFactory.make()
        controller = navigationController.pushViewController(controller)
        controller.coordinator = self
    }
    
}


//  MARK: - EXTENSION LoginViewControllerCoordinator
extension SignUpCoordinator: SignUpViewControllerCoordinator {
    func gotoLogin() {
        let coordinator = LoginCoordinator(navigationController)
        coordinator.start()
        childCoordinator = nil
    }

    func gotoHome() {
        let coordinator = HomeCoordinator(navigationController)
        coordinator.start()
        childCoordinator = nil
    }
    
}
