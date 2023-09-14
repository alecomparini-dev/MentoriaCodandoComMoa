//  Created by Alessandro Comparini on 30/08/23.
//

import UIKit

public protocol SignUpViewControllerCoordinator: AnyObject {
    func gotoLogin()
    func gotoHome()
}


public final class SignUpViewController: UIViewController {
    public weak var coordinator: SignUpViewControllerCoordinator?
    
    lazy var screen: SignUpView = {
        let view = SignUpView()
        return view
    }()
    
    public override func loadView() {
        view = screen
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
        screen.delegate = self
    }
}



//  MARK: - EXTENSION - HomeViewDelegate
extension SignUpViewController: SignUpViewDelegate {
    func backButtonTapped() {
        coordinator?.gotoLogin()
    }

    func signUpButtonTapped() {
        coordinator?.gotoHome()
    }

}



