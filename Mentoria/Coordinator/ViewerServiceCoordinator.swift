//  Created by Alessandro Comparini on 25/10/23.
//

import UIKit

import CustomComponentsSDK
import HomeUI
import HomePresenters

class ViewerServiceCoordinator: NSObject, Coordinator {
    var childCoordinator: Coordinator?
    unowned var navigationController: NavigationController
    
    var dataTransfer: Any?
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        childCoordinator = self
        let controller = ViewerServiceViewControllerFactory.make()
        controller.setDataTransfer(dataTransfer)
        controller.coordinator = self
        
        guard let currentScene = CurrentWindow.get else { return }
        let homeTabBar = currentScene.rootViewController

        if #available(iOS 15.0, *) {
            controller.setBottomSheet({ build in
                build
                    .setDetents(.medium)
                    .setDetents(.large)
                    .setCornerRadius(24)
                    .setGrabbervisible(false)
                    .setScrollingExpandsWhenScrolledToEdge(false)
            })
        }
        homeTabBar?.present(controller, animated: true)
    }
    
}


//  MARK: - EXTENSION - ViewerServiceViewControllerCoordinator
extension ViewerServiceCoordinator: ViewerServiceViewControllerCoordinator {
    
    func freeMemoryCoordinator() {
        childCoordinator = nil
    }
    
    func gotoEditService(_ servicePresenterDTO: ServicePresenterDTO?) {
        let nav = NavigationController()
        if let currentScene = CurrentWindow.get {
            currentScene.rootViewController = nav
        }
        let coordinator = AddServiceCoordinator(nav)
        coordinator.dataTransfer = servicePresenterDTO
        coordinator.start()
        childCoordinator = nil
    }
    
    func gotoListServiceHomeTabBar(_ vc: UIViewController, _ reloadTable: Bool = false) {
        vc.dismiss(animated: true)
        guard let currentScene = CurrentWindow.get else { return }
        let homeTabBar = currentScene.rootViewController
        let listServiceController = homeTabBar?.children[1] as? ListServicesViewController
        listServiceController?.setDataTransfer(reloadTable)
        childCoordinator = nil
        
    }
    
    
}

