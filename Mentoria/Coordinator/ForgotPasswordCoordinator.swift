//  Created by Alessandro Comparini on 31/10/23.
//

import ProfileUI

class ForgotPasswordCoordinator: Coordinator {
    
    var childCoordinator: Coordinator?
    unowned let navigationController: NavigationController

    var dataTransfer: Any?
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        childCoordinator = self
        var controller = ForgotPasswordViewControllerFactory.make()
        controller = navigationController.pushViewController(controller)
        controller.setDataTransfer(dataTransfer)
        controller.coordinator = self
    }

    
}


//  MARK: - EXTENSION - ForgotPasswordViewControllerCoordinator
extension ForgotPasswordCoordinator: ForgotPasswordViewControllerCoordinator {
    
    func gotoSignIn() {
        let coordinator = SignInCoordinator(navigationController)
        coordinator.start()
        childCoordinator = nil
    }
    
}
