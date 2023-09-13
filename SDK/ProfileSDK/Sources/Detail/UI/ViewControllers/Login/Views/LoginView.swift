//  Created by Alessandro Comparini on 30/08/23.
//

import UIKit
import DSMComponent
import CustomComponentsSDK


protocol LoginViewDelegate: AnyObject {
    func buttonTapped()
}

class LoginView: UIView {
    weak var delegate: LoginViewDelegate?
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
//  MARK: - LAZY AREA
    
    lazy var backgroundView: CustomView = {
        let comp = CustomView()
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return comp
    }()
    
    lazy var entradaCustomText: CustomText = {
        let comp = CustomText()
            .setText("Entrada")
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(24)
                    .setLeading.setTrailing.equalToSafeArea(16)
            }
        return comp
    }()
    
    lazy var emailCustomText: CustomText = {
        let comp = CustomText()
            .setText("Email:")
            .setConstraints { build in
                build
                    .setTop.equalTo(entradaCustomText.get, .bottom, 56)
                    .setLeading.setTrailing.equalTo(entradaCustomText.get)
            }
        return comp
    }()
    
    lazy var emailTextField: TextFieldImageBuilder = {
        let personImg = ImageViewBuilder(systemName: "person")
        let comp = TextFieldImageBuilder("Digite seu e-mail")
            .setBackgroundColor(hexColor: "#ffffff")
            .setImage(personImg, .right, 8)
            .setPadding(8)
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(emailCustomText.get, .bottom, 16)
                    .setLeading.setTrailing.equalTo(entradaCustomText.get)
                    .setHeight.equalToConstant(48)
            }
        return comp
    }()

    lazy var passwordText: CustomText = {
        let label = CustomText()
            .setText("Senha")
            .setConstraints { build in
                build
                    .setTop.equalTo(emailTextField.get, .bottom, 24)
                    .setLeading.setTrailing.equalTo(emailCustomText.get)
            }
        return label
    }()
    
    lazy var passwordTextField: TextFieldPasswordBuilder = {
        let comp = TextFieldPasswordBuilder(paddingRightImage: 8)
            .setBackgroundColor(hexColor: "#ffffff")
            .setPadding(8)
            .setPlaceHolder("Digite sua senha")
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(passwordText.get, .bottom, 16)
                    .setLeading.setTrailing.equalTo(emailTextField.get)
                    .setHeight.equalToConstant(48)
            }
        return comp
    }()
    
    lazy var rememberSwitch: SwitchBuilder = {
        let comp = SwitchBuilder()
            .setIsOn(false)
            .setConstraints { build in
                build
                    .setTop.equalTo(passwordTextField.get, .bottom, 24)
                    .setLeading.equalTo(passwordTextField.get, .leading)
            }
        return comp
    }()

    
    lazy var rememberText: CustomText = {
        let label = CustomText()
            .setText("Lembrar")
            .setTextAlignment(.center)
            .setSize(14)
            .setConstraints { build in
                build
                    .setLeading.equalTo(rememberSwitch.get, .trailing, 8)
                    .setVerticalAlignmentY.equalTo(rememberSwitch.get)
            }
        return label
    }()
    
    
    lazy var signInButtom: CustomButtonPrimary = {
        let comp = CustomButtonPrimary("Entrar")
            .setConstraints { build in
                build
                    .setTop.equalTo(rememberSwitch.get, .bottom, 48)
                    .setLeading.setTrailing.equalToSafeArea(44)
                    .setHeight.equalToConstant(48)
            }
        comp.get.addTarget(self, action: #selector(buttonPrimaryTapped), for: .touchUpInside)
        return comp
    }()
    @objc private func buttonPrimaryTapped() {
        delegate?.buttonTapped()
    }
    
    lazy var signUpButtom: CustomButtonSecondary = {
        let comp = CustomButtonSecondary("Cadastra-se")
            .setConstraints { build in
                build
                    .setTop.equalTo(signInButtom.get, .bottom, 8)
                    .setLeading.setTrailing.setHeight.equalTo(signInButtom.get)
            }
        return comp
    }()
    

//  MARK: - PRIVATE AREA
    public func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        addSubview(backgroundView.get)
        addSubview(entradaCustomText.get)
        addSubview(emailCustomText.get)
        addSubview(emailTextField.get)
        addSubview(passwordText.get)
        addSubview(passwordTextField.get)
        addSubview(rememberSwitch.get)
        addSubview(rememberText.get)
        
        addSubview(signInButtom.get)
        addSubview(signUpButtom.get)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        entradaCustomText.applyConstraint()
        emailCustomText.applyConstraint()
        emailTextField.applyConstraint()
        passwordText.applyConstraint()
        passwordTextField.applyConstraint()
        rememberSwitch.applyConstraint()
        rememberText.applyConstraint()
        
        signInButtom.applyConstraint()
        signUpButtom.applyConstraint()
    }
    
    
}
