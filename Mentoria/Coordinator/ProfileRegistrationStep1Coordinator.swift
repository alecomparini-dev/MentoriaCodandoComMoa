//  Created by Alessandro Comparini on 13/10/23.
//

import Foundation
import ProfileUI

class ProfileRegistrationStep1Coordinator: Coordinator {
    var childCoordinator: Coordinator?
    
    unowned let navigationController: NavigationController
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        childCoordinator = self
        var controller = ProfileRegistrationStep1ViewController()
        controller = navigationController.pushViewController(controller)
        controller.coordinator = self
    }

}



//  MARK: - EXTENSION LoginViewControllerCoordinator
extension ProfileRegistrationStep1Coordinator: ProfileRegistrationStep1ViewControllerCoordinator {
    
    func gotoProfileHomeTabBar() {
        let coodinator = HomeTabBarCoordinator(navigationController)
        coodinator.start()
        coodinator.selectedTabBarItem(0)
        childCoordinator = nil
    }
    
    func gotoProfileRegistrationStep2() {
        let coordinator = ProfileRegistrationStep2Coordinator(navigationController)
        coordinator.start()
        childCoordinator = nil

    }
        
}