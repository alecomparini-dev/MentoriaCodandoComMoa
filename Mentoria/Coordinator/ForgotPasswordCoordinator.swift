//  Created by Alessandro Comparini on 31/10/23.
//

import ProfileUI

class ForgotPasswordCoordinator: Coordinator {
    
    var coordinator: Coordinator?
    unowned let navigationController: NavigationController

    var dataTransfer: Any?
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        coordinator = self
        
        var controller: ForgotPasswordViewController!
        
        controller = navigationController.popToViewControllerIfNeeded(ForgotPasswordViewController.self)
        
        if controller == nil {
            controller = ForgotPasswordViewControllerFactory.make()
            controller = navigationController.pushViewController(controller)
        }
        
        controller.setDataTransfer(dataTransfer)
        controller.coordinator = self
    }
    
    
}


//  MARK: - EXTENSION - ForgotPasswordViewControllerCoordinator
extension ForgotPasswordCoordinator: ForgotPasswordViewControllerCoordinator {
    
    func gotoSignIn() {
        let coordinator = SignInCoordinator(navigationController)
        coordinator.start()
        self.coordinator = nil
    }
    
}
