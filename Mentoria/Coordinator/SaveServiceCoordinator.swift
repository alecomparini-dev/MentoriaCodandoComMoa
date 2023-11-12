//  Created by Alessandro Comparini on 24/10/23.
//

import Foundation

import HomeUI

class SaveServiceCoordinator: Coordinator {
    var childCoordinator: Coordinator?
    unowned var navigationController: NavigationController
    
    var dataTransfer: Any?
        
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

//  MARK: - EXTENSION - SaveServiceViewControllerCoordinator
extension SaveServiceCoordinator: SaveServiceViewControllerCoordinator {
    
    public func gotoListServiceHomeTabBar(_ reload: Bool) {
        let coodinator = HomeTabBarCoordinator(navigationController)
        coodinator.dataTransfer = reload
        coodinator.start()
        coodinator.selectedTabBarItem(1)
        childCoordinator = nil
    }
    
    
}
