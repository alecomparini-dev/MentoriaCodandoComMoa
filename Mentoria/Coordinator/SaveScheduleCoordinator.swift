//  Created by Alessandro Comparini on 01/12/23.
//

import Foundation

import HomeUI

class SaveScheduleCoordinator: Coordinator {
    var coordinator: Coordinator?
    unowned var navigationController: NavigationController
    
    var dataTransfer: Any?
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        coordinator = self
        
        var controller: SaveScheduleViewController!
        
        controller = navigationController.popToViewControllerIfNeeded(SaveScheduleViewController.self)
        
        if controller == nil {
            controller = SaveScheduleViewControllerFactory.make()
            controller = navigationController.pushViewController(controller)
        }
        
        controller.setDataTransfer(dataTransfer)
        controller.coordinator = self
    }
    
}

//  MARK: - EXTENSION - SaveScheduleViewControllerCoordinator
extension SaveScheduleCoordinator: SaveScheduleViewControllerCoordinator {
    
    func gotoListScheduleHomeTabBar(_ reload: Bool) {
        let coodinator = HomeTabBarCoordinator(navigationController)
        coodinator.dataTransfer = reload
        coodinator.start()
        coodinator.selectedTabBarItem(2)
        coordinator = nil
    }
    
    
}
