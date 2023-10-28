//  Created by Alessandro Comparini on 24/10/23.
//

import Foundation

import HomeUI

public class AddServiceCoordinator: Coordinator {
    var childCoordinator: Coordinator?
    
    var dataTransfer: Any?
    
    unowned var navigationController: NavigationController
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        childCoordinator = self
        var controller = AddServiceViewControllerFactory.make()
        controller = navigationController.pushViewController(controller)
        controller.setDataTransfer(dataTransfer)
        controller.coordinator = self
    }

    
}

//  MARK: - EXTENSION - AddServiceViewControllerCoordinator
extension AddServiceCoordinator: AddServiceViewControllerCoordinator {
    
    public func gotoListServiceHomeTabBar() {
        let coodinator = HomeTabBarCoordinator(navigationController)
        coodinator.start()
        coodinator.selectedTabBarItem(1)
        childCoordinator = nil
    }
    
    
}
