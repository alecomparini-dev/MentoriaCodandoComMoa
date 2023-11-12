//  Created by Alessandro Comparini on 30/08/23.
//

import UIKit
import CustomComponentsSDK
import DesignerSystemSDKComponent
import ProfilePresenters


public protocol SignInViewControllerCoordinator: AnyObject {
    func gotoHome()
    func gotoSignIn()
    func gotoForgotPassword(_ userEmail: String?)
}

public final class SignInViewController: UIViewController {
    public weak var coordinator: SignInViewControllerCoordinator?
    
    private var callBiometricsFlow: Bool
    
    private var signInPresenter: SignInPresenter
    
    public init(signInPresenter: SignInPresenter, callBiometricsFlow: Bool) {
        self.signInPresenter = signInPresenter
        self.callBiometricsFlow = callBiometricsFlow
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var screen: SignInView = {
        let view = SignInView()
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
        screen.passwordLoginView.passwordTextField.setCloseEye()
        screen.passwordLoginView.passwordTextField.setText("")
        getEmailKeyChain()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    var overlayView: UIView?
    
//  MARK: - PRIVATE AREA
    private func configure() {
        configDelegate()
        getEmailKeyChain()
        biometricsFlow()
    }
    
    private func configDelegate() {
        screen.delegate = self
        signInPresenter.outputDelegate = self
    }
    
    private func getEmailKeyChain() {
        if let email = signInPresenter.getEmailKeyChain() {
            screen.emailLoginView.emailTextField.get.text = email
            screen.rememberSwitch.setIsOn(true)
            return
        }
        screen.emailLoginView.emailTextField.get.text = ""
        screen.rememberSwitch.setIsOn(false)
    }
    
    private func biometricsFlow() {
        if !isEmailFilledIn() { return }
        if let email = screen.emailLoginView.emailTextField.get.text {
            signInPresenter.loginByBiometry(email)
        }
    }
    
    private func isEmailFilledIn() -> Bool {
        guard let email = screen.emailLoginView.emailTextField.get.text else {return false}
        return !email.isEmpty
    }
    
    private func loadingSignInButton(_ isLoading: Bool) {
        if isLoading {
            screen.signInButton.setShowLoadingIndicator()
            return
        }
        screen.signInButton.setHideLoadingIndicator()
    }
    
    private func showLoadingLoginButton() {
        screen.signInButton.setShowLoadingIndicator { build in
            build
                .setColor(hexColor: "#282a36")
                .setHideWhenStopped(true)
        }
    }
    
    private func callLogin(_ email: String, _ password: String) {
        showLoadingLoginButton()
        let rememberEmail = screen.rememberSwitch.get.isOn
        signInPresenter.login(email: email, password: password, rememberEmail: rememberEmail)
        callBiometricsFlow = true
    }
        
}


//  MARK: - EXTENSION - LoginViewDelegate
extension SignInViewController: SignInViewDelegate {

    func signInTapped() {
        if let email = screen.emailLoginView.emailTextField.get.text,
           let password = screen.passwordLoginView.passwordTextField.get.text {
            
            if !email.isEmpty && password.isEmpty && callBiometricsFlow {
                signInPresenter.loginByBiometry(email)
                return
            }
            callLogin(email, password)
        }
    }
    
    func signUpTapped() {
        coordinator?.gotoSignIn()
    }
    
    func forgotPasswordButtonTapped() {
        coordinator?.gotoForgotPassword(screen.passwordLoginView.passwordTextField.get.text)
    }
}



//  MARK: - EXTENSION - LoginPresenterOutput
extension SignInViewController: SignInPresenterOutput {
    
    public func signInUserPasswordLogin(_ continueLoginUserPassword: Bool) {
        callBiometricsFlow = false
        if continueLoginUserPassword {
            signInTapped()
        }
    }
    
    
    public func askIfWantToUseBiometrics(title: String, message: String, completion: @escaping (_ acceptUseBiometrics: Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default) { _ in completion(true) }
        let actionCancel = UIAlertAction(title: "Cancelar", style: .cancel) { _ in completion(false) }
        alert.addAction(actionOk)
        alert.addAction(actionCancel)
        present(alert, animated: true)
    }
    
    public func loadingLogin(_ isLoading: Bool) {
        loadingSignInButton(isLoading)
    }
    
    public func successSignIn(_ userId: String) {
        coordinator?.gotoHome()
    }

    public func errorSignIn(_ error: String) {
        let alert = UIAlertController(title: "Aviso", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
        screen.signInButton.setHideLoadingIndicator()
    }
    
}




