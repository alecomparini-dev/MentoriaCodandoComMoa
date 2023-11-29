//  Created by Alessandro Comparini on 05/09/23.
//

import Foundation
import UIKit

import CustomComponentsSDK
import HomeUI
import HomePresenters
import ProfileUI
import ProfilePresenters

class HomeTabBarCoordinator: Coordinator {
    var childCoordinator: Coordinator?
    unowned var navigationController: NavigationController
    
    var dataTransfer: Any?
    
    private var homeTabBarControllers: HomeTabBar?
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        childCoordinator = self
        
        let profileSummaryTabBarItem = createProfileSummaryTabBarItem()
        let listServicesTabBarItem = createListServiceTabBarItem()
        let scheduleTabBarItem = scheduleTabBarItem()
        
        let homeTabBar = HomeTabBar(items: [profileSummaryTabBarItem, listServicesTabBarItem, scheduleTabBarItem])
        var controller = homeTabBar.tabBar.get
        controller = navigationController.pushViewController(controller)
        homeTabBarControllers = homeTabBar
        setCoordinator(controller)
    }
    
    func selectedTabBarItem(_ index: Int) {
        if let homeTabBarControllers {
            homeTabBarControllers.tabBar.get.selectedIndex = index
        }
        homeTabBarControllers = nil
    }
    
    
    
    //  MARK: - PRIVATE AREA
    private func createProfileSummaryTabBarItem() -> TabBarItems {
        let profileSummaryController = ProfileSummaryViewControllerFactory.make()
        return TabBarItems(viewController: profileSummaryController, image: ImageViewBuilder(systemName: "person"), title: "Perfil")
    }
    
    private func createListServiceTabBarItem() -> TabBarItems {
        let listServiceVC = ListServicesViewControllerFactory.make()
        return TabBarItems(viewController: listServiceVC, image: ImageViewBuilder(systemName: "wrench.and.screwdriver.fill"), title: "Serviços")
    }
    
    private func scheduleTabBarItem() -> TabBarItems {
        return TabBarItems(viewController: ScheduleViewController(), image: ImageViewBuilder(systemName: "calendar"), title: "Agenda")
    }
    
    private func setCoordinator(_ controller: UITabBarController) {
        let profileSummaryController = (controller.viewControllers?[0] as! ProfileSummaryViewController)
        profileSummaryController.coordinator = self
        profileSummaryController.setDataTransfer(dataTransfer)
        
        let listServicesController = (controller.viewControllers?[1] as! ListServicesViewController)
        listServicesController.coordinator = self
        listServicesController.setDataTransfer(dataTransfer)
        
        let scheduleViewController = (controller.viewControllers?[2] as! ScheduleViewController)
        scheduleViewController.coordinator = self
        
    }
    
}


//  MARK: - EXTENSION - ProfileSummaryViewControllerCoordinator
extension HomeTabBarCoordinator: ProfileSummaryViewControllerCoordinator {

    func gotoProfileRegistrationStep1(_ profilePresenterDTO: ProfilePresenterDTO?) {
        let coordinator = ProfileRegistrationStep1Coordinator(navigationController)
        coordinator.dataTransfer = profilePresenterDTO
        coordinator.start()
        childCoordinator = nil
    }

    func gotoSignIn() {
        let coordinator = SignInCoordinator(navigationController)
        let useBiometric = false
        coordinator.dataTransfer = useBiometric
        coordinator.start()
        childCoordinator = nil
    }
    
}


//  MARK: - EXTENSION - ListServicesViewControllerCoordinator
extension HomeTabBarCoordinator: ListServicesViewControllerCoordinator {
    
    func gotoSaveService(_ servicePresenterDTO: ServicePresenterDTO?) {
        let coordinator = SaveServiceCoordinator(navigationController)
        coordinator.dataTransfer = servicePresenterDTO
        coordinator.start()
        childCoordinator = nil
    }
    
    func gotoViewerService(_ servicePresenterDTO: ServicePresenterDTO?) {
        let coordinator = ViewerServiceCoordinator(navigationController)
        coordinator.dataTransfer = servicePresenterDTO
        coordinator.start()
    }

    
}


//  MARK: - EXTENSION - ScheduleViewControllerCoordinator
extension HomeTabBarCoordinator: ScheduleViewControllerCoordinator {
    
}
