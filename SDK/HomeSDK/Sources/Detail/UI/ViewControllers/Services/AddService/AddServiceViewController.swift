//  Created by Alessandro Comparini on 24/10/23.
//

import UIKit

public protocol AddServiceViewControllerCoordinator: AnyObject {
    func gotoListServiceHomeTabBar()
}

public class AddServiceViewController: UIViewController {
    public weak var coordinator: AddServiceViewControllerCoordinator?
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public lazy var screen: AddServiceView = {
        let view = AddServiceView()
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
        
    }
    
    private func configDelegate() {
        
    }
    
    
}
