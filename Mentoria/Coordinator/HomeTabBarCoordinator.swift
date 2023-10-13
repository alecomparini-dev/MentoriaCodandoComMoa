//  Created by Alessandro Comparini on 05/09/23.
//

import Foundation

import HomeUI
import ProfileUI
import CustomComponentsSDK

class HomeCoordinator: Coordinator {
    var childCoordinator: Coordinator?
    unowned let navigationController: NavigationController
    
    private var homeTabBarControllers: HomeTabBar?
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        childCoordinator = self
        
        let profileSummaryController = ProfileSummaryViewController()
        
        let profileSummaryTabItem = TabBarItems(viewController: profileSummaryController, image: ImageViewBuilder(systemName: "person"), title: "Perfil")
        
        let homeController = TabBarItems(viewController: HomeViewController(), image: ImageViewBuilder(systemName: "wrench.and.screwdriver.fill"), title: "Seu Serviço")
        let item3 = TabBarItems(viewController: HomeViewController(), image: ImageViewBuilder(systemName: "calendar"), title: "Agenda")
        
        homeTabBarControllers = HomeTabBar(items: [profileSummaryTabItem, homeController, item3])
        
        if let currentScene = CurrentWindow.get, let homeTabBarControllers {
            currentScene.rootViewController = homeTabBarControllers.tabBar.get
        }
        
    }
    
    func selectedTabBarItem(_ index: Int) {
        if let homeTabBarControllers {
            homeTabBarControllers.tabBar.get.selectedIndex = index
        }
    }
    
}

