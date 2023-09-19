//  Created by Alessandro Comparini on 30/08/23.
//

import UIKit
import ProfilePresenters

public protocol SignUpViewControllerCoordinator: AnyObject {
    func gotoLogin()
    func gotoHome()
}


public final class SignUpViewController: UIViewController {
    public weak var coordinator: SignUpViewControllerCoordinator?
    
    private var signUpPresenter: SignUpPresenter
    
    public init(signUpPresenter: SignUpPresenter) {
        self.signUpPresenter = signUpPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        signUpPresenter.outputDelegate = self
    }
}



//  MARK: - EXTENSION - HomeViewDelegate
extension SignUpViewController: SignUpViewDelegate {
    func backButtonTapped() {
        coordinator?.gotoLogin()
    }

    func signUpButtonTapped() {
        if let email = screen.emailLoginView.emailTextField.get.text,
           let password = screen.passwordLoginView.passwordTextField.get.text,
           let passwordConfirmation = screen.confirmationPasswordText.get.text {
            signUpPresenter.createLogin(email: email, password: password, passwordConfirmation: passwordConfirmation)
        }

    }

}


//  MARK: - EXTENSION -
extension SignUpViewController: SignUpPresenterOutput {
    
    public func success(_ userId: String) {
        coordinator?.gotoHome()
    }

    
    public func error(_ error: String) {
        let alert = UIAlertController(title: "Aviso", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}
