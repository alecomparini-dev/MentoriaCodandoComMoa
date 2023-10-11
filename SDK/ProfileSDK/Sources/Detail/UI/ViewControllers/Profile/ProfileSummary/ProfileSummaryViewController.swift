//  Created by Alessandro Comparini on 09/10/23.
//

import UIKit


public final class ProfileSummaryViewController: UIViewController {
    
    lazy var screen: ProfileSummaryView = {
        let view = ProfileSummaryView(viewController: self)
        return view
    }()

    
//  MARK: - LIFE CYCLE

    public override func loadView() {
        self.view = screen
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
//        configDelegate()
    }
}
