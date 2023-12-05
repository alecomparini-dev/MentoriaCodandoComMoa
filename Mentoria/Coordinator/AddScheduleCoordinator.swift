//  Created by Alessandro Comparini on 01/12/23.
//

import Foundation

import HomeUI

class AddScheduleCoordinator: Coordinator {
    var childCoordinator: Coordinator?
    unowned var navigationController: NavigationController
    
    var dataTransfer: Any?
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        childCoordinator = self
        
        var controller: AddScheduleViewController!
        
        controller = navigationController.popToViewControllerIfNeeded(AddScheduleViewController.self)
        
        if controller == nil {
            controller = AddScheduleViewControllerFactory.make()
            controller = navigationController.pushViewController(controller)
        }
        
        controller.setDataTransfer(dataTransfer)
        controller.coordinator = self
    }
    
}

//  MARK: - EXTENSION - AddScheduleViewControllerCoordinator
extension AddScheduleCoordinator: AddScheduleViewControllerCoordinator {
    
    func gotoListScheduleHomeTabBar(_ reload: Bool) {
        let coodinator = HomeTabBarCoordinator(navigationController)
        coodinator.dataTransfer = reload
        coodinator.start()
        coodinator.selectedTabBarItem(2)
        childCoordinator = nil
    }
    
    
}
