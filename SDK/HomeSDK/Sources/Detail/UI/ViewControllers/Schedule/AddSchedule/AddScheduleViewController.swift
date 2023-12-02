//  Created by Alessandro Comparini on 01/12/23.
//

import UIKit

public protocol AddScheduleViewControllerCoordinator: AnyObject {
    func gotoListScheduleHomeTabBar(_ reload: Bool)
}


public class AddScheduleViewController: UIViewController {
    public weak var coordinator: AddScheduleViewControllerCoordinator?
    
    
    //  MARK: - INITIALIZERS
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public lazy var screen: AddScheduleView = {
        let view = AddScheduleView()
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
    
    
    //  MARK: - DATA TRANSFER
    public func setDataTransfer(_ data: Any?) {
        
    }
    
    //  MARK: - PRIVATE AREA
    private func configure() {
        configDelegate()
        configButtonDisableSchedule()
    }
    
    private func configDelegate() {
        screen.delegate = self
    }
    
    private func configButtonDisableSchedule() {
        screen.disableScheduleButton.setHidden(
            false
//            saveServicePresenter.mustBeHiddenDisableServiceButton(servicePresenterDTO)
        )
    }
    
}


//  MARK: - EXTESION
extension AddScheduleViewController: AddScheduleViewDelegate {
    public func disableScheduleButtonTapped() {
        
    }
        
    public func backButtonTapped() {
        coordinator?.gotoListScheduleHomeTabBar(false)
    }

}

