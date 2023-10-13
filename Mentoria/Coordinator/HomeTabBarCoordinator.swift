//  Created by Alessandro Comparini on 05/09/23.
//

import Foundation
import UIKit

import HomeUI
import ProfileUI
import CustomComponentsSDK

class HomeTabBarCoordinator: Coordinator {
    var childCoordinator: Coordinator?
    
    unowned var navigationController: NavigationController
    
    private weak var homeTabBarControllers: HomeTabBar?
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        childCoordinator = self
        
        let profileSummaryTabBarItem = createProfileSummaryTabBarItem()
        let homeTabBarItem = createHomeTabBarItem()
        let scheduleTabBarItem = scheduleTabBarItem()
        
        let homeTabBar = HomeTabBar(items: [profileSummaryTabBarItem, homeTabBarItem, scheduleTabBarItem])
        
        if let currentScene = CurrentWindow.get {
            currentScene.rootViewController = homeTabBar.tabBar.get
        }
        
        homeTabBarControllers = homeTabBar
    }
    
    func selectedTabBarItem(_ index: Int) {
        if let homeTabBarControllers {
            homeTabBarControllers.tabBar.get.selectedIndex = index
        }
    }
    
    
//  MARK: - PRIVATE AREA
    private func createProfileSummaryTabBarItem() -> TabBarItems {
        let profileSummaryController = ProfileSummaryViewController()
        profileSummaryController.coordinator = self
        return TabBarItems(viewController: profileSummaryController, image: ImageViewBuilder(systemName: "person"), title: "Perfil")
    }
    
    private func createHomeTabBarItem() -> TabBarItems {
        return TabBarItems(viewController: HomeViewController(), image: ImageViewBuilder(systemName: "wrench.and.screwdriver.fill"), title: "Seu Serviço")
    }

    private func scheduleTabBarItem() -> TabBarItems {
        return TabBarItems(viewController: HomeViewController(), image: ImageViewBuilder(systemName: "calendar"), title: "Agenda")
    }

    
}


//  MARK: - EXTENSION - ProfileSummaryViewControllerCoordinator

extension HomeTabBarCoordinator: ProfileSummaryViewControllerCoordinator {
    
    func gotoProfileRegistrationStep1() {
        let nav = NavigationController()
        
        if let currentScene = CurrentWindow.get {
            currentScene.rootViewController = nav
        }
        
        let coordinator = ProfileRegistrationStep1Coordinator(nav)
        coordinator.start()
        childCoordinator = nil
        homeTabBarControllers = nil
    }
    
    
}
