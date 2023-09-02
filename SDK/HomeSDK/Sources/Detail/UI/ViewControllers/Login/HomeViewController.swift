//  Created by Alessandro Comparini on 30/08/23.
//

import UIKit
//import NetworkSDKMain

public final class HomeViewController: UIViewController {
    
    lazy var login: HomeView = {
        let view = HomeView()
        return view
    }()
    
    public override func loadView() {
        view = login
        
    }
    
}


