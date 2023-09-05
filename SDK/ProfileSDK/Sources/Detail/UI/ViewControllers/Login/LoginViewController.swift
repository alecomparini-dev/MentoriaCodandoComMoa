//
//  LoginViewController.swift
//  DetailLayer
//
//  Created by Alessandro Comparini on 30/08/23.
//

import UIKit

public final class LoginViewController: UIViewController {
    
    lazy var login: LoginView = {
        let view = LoginView()
        return view
    }()
    
    public override func loadView() {
        self.view = self.login
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}


