//  Created by Alessandro Comparini on 13/10/23.
//

import Foundation
import ProfileUI
import ProfilePresenters

class ProfileRegistrationStep1Coordinator: Coordinator {
    var childCoordinator: Coordinator?
    
    unowned let navigationController: NavigationController
    
    var dataTransfer: Any?
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        childCoordinator = self
        var controller = ProfileRegistrationStep1Factory.make()
        controller = navigationController.pushViewController(controller)
        controller.setDataTransfer(dataTransfer)
        controller.coordinator = self
    }

}



//  MARK: - EXTENSION - ProfileRegistrationStep1ViewControllerCoordinator
extension ProfileRegistrationStep1Coordinator: ProfileRegistrationStep1ViewControllerCoordinator {
    
    func gotoProfileHomeTabBar() {
        let coodinator = HomeTabBarCoordinator(navigationController)
        coodinator.start()
        coodinator.selectedTabBarItem(0)
        childCoordinator = nil
    }
    
    func gotoProfileRegistrationStep2(_ profilePresenterDTO: ProfilePresenterDTO?) {
        let coordinator = ProfileRegistrationStep2Coordinator(navigationController)
        coordinator.dataTransfer = profilePresenterDTO
        coordinator.start()
        childCoordinator = nil
    }
        
}
