//  Created by Alessandro Comparini on 31/10/23.
//

import UIKit

import ProfilePresenters

public protocol ForgotPasswordViewControllerCoordinator: AnyObject {
    func gotoSignIn()
}

public class ForgotPasswordViewController: UIViewController {
    public weak var coordinator: ForgotPasswordViewControllerCoordinator?
    
    private var forgotPasswordPresenter: ForgotPasswordPresenter
    
    public init(forgotPasswordPresenter: ForgotPasswordPresenter) {
        self.forgotPasswordPresenter = forgotPasswordPresenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var screen: ForgotPasswordView = {
        let view = ForgotPasswordView()
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
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    

//  MARK: - DATA TRANSFER
    public func setDataTransfer(_ data: Any?) {
        if let email = data as? String {
            screen.emailLoginView.emailTextField.setText(email)
        }
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        configDelegate()
    }
    
    private func configDelegate() {
        screen.delegate = self
        forgotPasswordPresenter.outputDelegate = self
    }
    
}


//  MARK: - EXTENSION - ForgotPasswordViewDelegate
extension ForgotPasswordViewController: ForgotPasswordViewDelegate {
    
    func backButtonTapped() {
        coordinator?.gotoSignIn()
    }

    func resetButtonTapped() {
        forgotPasswordPresenter.resetPassword(screen.emailLoginView.emailTextField.get.text)
    }
    
}


//  MARK: - EXTENSION - ForgotPasswordPresenterOutput
extension ForgotPasswordViewController: ForgotPasswordPresenterOutput {
    public func validations(validationsError: String?) {
        let alert = UIAlertController(title: "Aviso", message: validationsError, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
    public func successResetPassword() {
        let alert = UIAlertController(title: "Redefinir Senha", message: "Em alguns instantes você receberá no seu email o link para redefinir a senha", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default,handler: { [weak self] _ in
            self?.coordinator?.gotoSignIn()
        })
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    public func errorResetPassword(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
}
