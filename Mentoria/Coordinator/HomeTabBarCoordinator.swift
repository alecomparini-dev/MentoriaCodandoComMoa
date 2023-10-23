//  Created by Alessandro Comparini on 05/09/23.
//

import Foundation
import UIKit

import CustomComponentsSDK
import HomeUI
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
        
        if let currentScene = CurrentWindow.get {
            currentScene.rootViewController = homeTabBar.tabBar.get
        }

        homeTabBarControllers = homeTabBar
    }
    
    func selectedTabBarItem(_ index: Int) {
        if let homeTabBarControllers {
            homeTabBarControllers.tabBar.get.selectedIndex = index
        }
        homeTabBarControllers = nil
    }
    
    
//  MARK: - PRIVATE AREA
    private func createProfileSummaryTabBarItem() -> TabBarItems {
        
        let profileSummaryController = ProfileSummaryFactory.make()
        profileSummaryController.coordinator = self
        return TabBarItems(viewController: profileSummaryController, image: ImageViewBuilder(systemName: "person"), title: "Perfil")
    }
    
    private func createListServiceTabBarItem() -> TabBarItems {
        let listServiceVC = ListServicesViewController()
        listServiceVC.coordinator = self
        return TabBarItems(viewController: listServiceVC, image: ImageViewBuilder(systemName: "wrench.and.screwdriver.fill"), title: "Serviços")
    }

    private func scheduleTabBarItem() -> TabBarItems {
        return TabBarItems(viewController: HomeViewController(), image: ImageViewBuilder(systemName: "calendar"), title: "Agenda")
    }

    
}


//  MARK: - EXTENSION - ProfileSummaryViewControllerCoordinator
extension HomeTabBarCoordinator: ProfileSummaryViewControllerCoordinator {
    
    func gotoProfileRegistrationStep1(_ profilePresenterDTO: ProfilePresenterDTO?) {
        let nav = NavigationController()
        
        if let currentScene = CurrentWindow.get {
            currentScene.rootViewController = nav
        }
        
        let coordinator = ProfileRegistrationStep1Coordinator(nav)
        coordinator.dataTransfer = profilePresenterDTO
        coordinator.start()
        childCoordinator = nil
    }
    
    
}


//  MARK: - EXTENSION - ListServicesViewControllerCoordinator
extension HomeTabBarCoordinator: ListServicesViewControllerCoordinator {
    func gotoSaveService() {
        
    }
    
    func gotoViewerService() {
        
    }
    
    
}
