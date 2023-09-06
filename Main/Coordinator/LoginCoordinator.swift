//  Created by Alessandro Comparini on 05/09/23.
//

import Foundation
import ProfileUI

class LoginCoordinator: Coordinator {
    var childCoordinator: Coordinator?
    
    unowned let navigationController: NavigationController
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        childCoordinator = self
        var controller = LoginViewController()
        controller = navigationController.pushViewController(controller)
        controller.coordinator = self
    }
    
}


//  MARK: - EXTENSION LoginViewControllerCoordinator
extension LoginCoordinator: LoginViewControllerCoordinator {
    
    func gotoHome() {
        let coordinator = HomeCoordinator(navigationController)
        coordinator.start()
        childCoordinator = nil
    }
    
}
