//  Created by Alessandro Comparini on 26/09/23.
//

import UIKit
import CustomComponentsSDK

public class HomeTabBar {
    
    public var tabBar: TabBarBuilder
    private let items: [TabBarItems]
    
    public init(items: [TabBarItems]) {
        self.tabBar = TabBarBuilder()
        self.items = items
        configure()
    }
    
    private func configure() {
        tabBar
            .setTranslucent(true)
            .setIsNavigationBarHidden(true)
            .setBackGroundColor(hexColor: "#363a51")
            .setUnselectedItemTintColor(color: UIColor.HEX("#FFFFFF").withAlphaComponent(0.5))
            .setTintColor(hexColor: "#FFFFFF")
            .setItems(items: items)
    }
       
}
