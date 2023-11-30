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
        screen.listSchedule.show()
    }
    
    private func configDelegate() {
        screen.dock.setDelegate(delegate: self)
        screen.listSchedule.setDelegate(delegate: self)
    }
    
}



//  MARK: - EXTESION - DockDelegate

extension ScheduleViewController: DockDelegate {
    
    public func numberOfItemsCallback() -> Int {
        return 31
    }
    
    public func cellItemCallback(_ indexItem: Int) -> UIView {
        return ViewBuilder()
            .setBackgroundColor(hexColor: "#fa79c7")
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


//  MARK: - EXTESION - ListDelegate

extension ScheduleViewController: ListDelegate {
    
    public func numberOfSections() -> Int {
        return 2
    }
    
    public func numberOfRows(section: Int) -> Int {
        switch section {
            case 0:
                return 2
            case 1:
                return 10
            default:
                return 0
        }
    }
    
    public func sectionViewCallback(section: Int) -> UIView? {
//        let view = ViewBuilder()
        let label = LabelBuilder(" Alessandro - \(section)")
            .setSize(24)
            .setColor(.red)
            .setWeight(.black)
            .setShadow({ build in
                build
                    .setColor(.black)
                    .setOffset(CGSize(width: 2, height: 2))
                    .setRadius(4)
            })
            .setConstraints { build in
                build.setPin.equalToSafeArea
            }
        
        
        return label.get
        
    }
    
    public func rowViewCallBack(section: Int, row: Int) -> UIView {
        return ViewBuilder()
            .get
    }
    
    
    
}
