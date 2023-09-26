//  Created by Alessandro Comparini on 05/09/23.
//

import Foundation
import HomeUI
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
        let items = TabBarItems(viewController: HomeViewController(), image: ImageViewBuilder(systemName: "mic"), title: "Seu Serviço")
        let item2 = TabBarItems(viewController: HomeViewController(), image: ImageViewBuilder(systemName: "person"), title: "Person")
        let controller = HomeTabBar(items: [items, item2])
        if let currentScene = CurrentWindow.get {
            currentScene.rootViewController = controller.tabBar.get
        }
    }
    
}

