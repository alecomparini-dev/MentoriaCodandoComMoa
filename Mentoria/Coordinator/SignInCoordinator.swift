//  Created by Alessandro Comparini on 05/09/23.
//

import Foundation
import ProfileUI

class SignInCoordinator: Coordinator {
    var childCoordinator: Coordinator?
    unowned let navigationController: NavigationController
    var dataTransfer: Any?
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        childCoordinator = self
        var controller = LoginViewControllerFactory.make()
        controller = navigationController.pushViewController(controller)
        controller.coordinator = self
    }
    
}


//  MARK: - EXTENSION LoginViewControllerCoordinator
extension SignInCoordinator: SignInViewControllerCoordinator {
    func gotoLogin() {
        let coordinator = SignUpCoordinator(navigationController)
        coordinator.start()
        childCoordinator = nil
    }
    
    func gotoHome() {
        let coordinator = HomeTabBarCoordinator(navigationController)
        coordinator.start()
        coordinator.selectedTabBarItem(1)
        childCoordinator = nil
    }
    
}
