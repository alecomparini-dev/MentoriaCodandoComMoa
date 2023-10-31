//  Created by Alessandro Comparini on 31/10/23.
//

import Foundation
import ProfileUI

class LoadScreenCoordinator: Coordinator {
    var childCoordinator: Coordinator?
    unowned let navigationController: NavigationController
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        childCoordinator = self
        var controller = LoadScreenViewController()
        controller = navigationController.pushViewController(controller)
        controller.coordinator = self
    }

}


extension LoadScreenCoordinator: LoadScreenViewControllerCoordinator {
    func gotoSignIn() {
        let coordinator = SignInCoordinator(navigationController)
        coordinator.start()
        childCoordinator = nil
    }
    
}
