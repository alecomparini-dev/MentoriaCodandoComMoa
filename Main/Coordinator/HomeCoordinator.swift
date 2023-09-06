//  Created by Alessandro Comparini on 05/09/23.
//

import Foundation
import HomeUI

class HomeCoordinator: Coordinator {
    var childCoordinator: Coordinator?
    
    unowned let navigationController: NavigationController
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        childCoordinator = self
        var controller = HomeViewController()
        controller = navigationController.pushViewController(controller)
        controller.coordinator = self
    }
    
}

extension HomeCoordinator: HomeViewControllerCoordinator {
    
    func gotoLogin() {
        let coordinator = LoginCoordinator(navigationController)
        coordinator.start()
        childCoordinator = nil
    }
    
    
}
