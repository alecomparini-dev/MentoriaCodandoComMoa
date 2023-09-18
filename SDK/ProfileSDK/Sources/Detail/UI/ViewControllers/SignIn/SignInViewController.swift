//
//  SignInViewController.swift
//  DetailLayer
//
//  Created by Alessandro Comparini on 30/08/23.
//

import UIKit
import CustomComponentsSDK
import DSMMain
import ProfilePresenters


public protocol SignInViewControllerCoordinator: AnyObject {
    func gotoHome()
    func gotoLogin()
}

public final class SignInViewController: UIViewController {
    public weak var coordinator: SignInViewControllerCoordinator?
    
    private var signInPresenter: SignInPresenter
    
    public init(signInPresenter: SignInPresenter) {
        self.signInPresenter = signInPresenter
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
        self.view = self.screen
    }
    
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
        signInPresenter.outputDelegate = self
    }
    
    
}


//  MARK: - EXTENSION - LoginViewDelegate
extension SignInViewController: SignInViewDelegate {
    
    func signInTapped() {
        if let email = screen.emailLoginView.emailTextField.get.text,
           let password = screen.passwordLoginView.passwordTextField.get.text {
            signInPresenter.login(email: email, password: password)
        }        
    }
    
    func signUpTapped() {
        coordinator?.gotoLogin()
    }
    
}



//  MARK: - EXTENSION - LoginPresenterOutput
extension SignInViewController: SignInPresenterOutput {
    
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
