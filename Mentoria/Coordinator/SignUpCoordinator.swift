//  Created by Alessandro Comparini on 14/09/23.
//

import Foundation

import ProfileUI

class SignUpCoordinator: Coordinator {
    var childCoordinator: Coordinator?
    unowned let navigationController: NavigationController
    
    var dataTransfer: Any?
    
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
    func gotoSignIn() {
        let coordinator = SignInCoordinator(navigationController)
        coordinator.start()
        childCoordinator = nil
    }

    func gotoHome() {
        let coordinator = HomeTabBarCoordinator(navigationController)
        coordinator.start()
        childCoordinator = nil
    }
    
}
