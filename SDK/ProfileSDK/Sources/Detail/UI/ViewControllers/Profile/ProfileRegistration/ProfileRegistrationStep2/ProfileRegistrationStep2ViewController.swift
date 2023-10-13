//  Created by Alessandro Comparini on 13/10/23.
//

import UIKit

public protocol ProfileRegistrationStep2ViewControllerCoordinator: AnyObject {
    func gotoProfileRegistrationStep1()
    func gotoProfileHomeTabBar()
}


public final class ProfileRegistrationStep2ViewController: UIViewController {

    public weak var coordinator: ProfileRegistrationStep2ViewControllerCoordinator?
    
    lazy var screen: ProfileRegistrationStep2View = {
        let view = ProfileRegistrationStep2View()
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
        configDelegate()
    }
    
    private func configDelegate() {
        screen.delegate = self
    }
    
    
}


//  MARK: - EXTENSION TABLEVIEW DELEGATE
extension ProfileRegistrationStep2ViewController: ProfileRegistrationStep2ViewDelegate {
    
    func backButtonTapped() {
        coordinator?.gotoProfileRegistrationStep1()
    }
    
}
