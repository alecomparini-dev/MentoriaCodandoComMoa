//  Created by Alessandro Comparini on 29/11/23.
//

import UIKit
import CustomComponentsSDK

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
        screen.dock.show()
    }
    
    private func configDelegate() {
        screen.dock.setDelegate(delegate: self)
    }
}


//  MARK: - EXTESION - ScheduleViewController
extension ScheduleViewController: DockDelegate {
    
    public func numberOfItemsCallback() -> Int {
        return 10
    }
    
    public func cellItemCallback(_ indexItem: Int) -> UIView {
        return ViewBuilder()
            .setBackgroundColor(.systemPink)
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .get
    }
    
    public func didSelectItemAt(_ indexItem: Int) {
        print("SELECIONOU:", indexItem)
    }
    
    public func didDeselectItemAt(_ indexItem: Int) {
        print("RETIROU:", indexItem)
    }
    
}
