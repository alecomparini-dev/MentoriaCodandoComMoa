//  Created by Alessandro Comparini on 29/11/23.
//

import UIKit

public protocol ScheduleViewControllerCoordinator: AnyObject {
    
}

public final class ScheduleViewController: UIViewController {
    public weak var coordinator: ScheduleViewControllerCoordinator?
    
    lazy var screen: ScheduleView = {
        let view = ScheduleView()
        return view
    }()
    
    public override func loadView() {
        view = screen
        navigationController?.isNavigationBarHidden = true
    }

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
//  MARK: - LIFE CYCLE
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        configDelegate()
    }
    
    private func configDelegate() {
//        screen.delegate = self
    }
}
