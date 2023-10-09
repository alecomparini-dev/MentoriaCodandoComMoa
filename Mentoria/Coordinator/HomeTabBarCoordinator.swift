//  Created by Alessandro Comparini on 05/09/23.
//

import Foundation
import HomeUI
import ProfileUI
import CustomComponentsSDK
import UIKit

class HomeCoordinator: Coordinator {
    var childCoordinator: Coordinator?
    
    unowned let navigationController: NavigationController
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        childCoordinator = self
        let item1 = TabBarItems(viewController: ProfileSummaryViewController(), image: ImageViewBuilder(systemName: "person"), title: "Perfil")
        let item2 = TabBarItems(viewController: HomeViewController(), image: ImageViewBuilder(systemName: "wrench.and.screwdriver.fill"), title: "Seu Serviço")
        let item3 = TabBarItems(viewController: HomeViewController(), image: ImageViewBuilder(systemName: "calendar"), title: "Agenda")
        let controller = HomeTabBar(items: [item1, item2, item3])
        if let currentScene = CurrentWindow.get {
            currentScene.rootViewController = controller.tabBar.get
        }
    }
    
}

