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
        
        let profileSummaryController = ProfileSummaryViewController()
        profileSummaryController.coordinator = self
        
        let profileSummaryTabItem = TabBarItems(viewController: profileSummaryController, image: ImageViewBuilder(systemName: "person"), title: "Perfil")
        
        let homeController = TabBarItems(viewController: HomeViewController(), image: ImageViewBuilder(systemName: "wrench.and.screwdriver.fill"), title: "Seu Serviço")
        
        let item3 = TabBarItems(viewController: UIViewController(), image: ImageViewBuilder(systemName: "calendar"), title: "Agenda")
        
        let homeTabBar = HomeTabBar(items: [profileSummaryTabItem, homeController, item3])
        
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
    
}


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
