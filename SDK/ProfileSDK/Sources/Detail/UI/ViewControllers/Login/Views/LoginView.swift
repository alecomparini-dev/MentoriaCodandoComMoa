//  Created by Alessandro Comparini on 30/08/23.
//

import UIKit
import DSMComponent
import CustomComponentsSDK


protocol LoginViewDelegate: AnyObject {
    func signUpTapped()
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
    
    lazy var signInCustomTextTitle: CustomTextTitle = {
        let comp = CustomTextTitle()
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
                    .setTop.equalTo(signInCustomTextTitle.get, .bottom, 56)
                    .setLeading.setTrailing.equalTo(signInCustomTextTitle.get)
            }
        return comp
    }()
    
    lazy var emailTextField: TextFieldImageBuilder = {
        let personImg = ImageViewBuilder(systemName: "person")
        let comp = TextFieldImageBuilder("Digite seu e-mail")
            .setBackgroundColor(hexColor: "#ffffff")
            .setImage(personImg, .right, 8)
            .setPadding(8)
            .setKeyboard({ build in
                build
                    .setKeyboardType(.emailAddress)
                    .setDoneButton { textField in
                        print("OK")
                    }
            })
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(emailCustomText.get, .bottom, 16)
                    .setLeading.setTrailing.equalTo(signInCustomTextTitle.get)
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
            .setKeyboard({ buid in
                buid
                    .setKeyboardType(.default)
            })
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
    
    lazy var rememberSwitch: CustomSwitchSecondary = {
        let comp = CustomSwitchSecondary()
            .setConstraints { build in
                build
                    .setTop.equalTo(passwordTextField.get, .bottom, 24)
                    .setLeading.equalTo(passwordTextField.get, .leading)
            }
        return comp
    }()

    lazy var rememberText: CustomTextSecondary = {
        let label = CustomTextSecondary()
            .setText("Lembrar")
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
        return comp
    }()
    
    
    lazy var signUpButtom: CustomButtonSecondary = {
        let comp = CustomButtonSecondary("Cadastra-se")
            .setConstraints { build in
                build
                    .setTop.equalTo(signInButtom.get, .bottom, 16)
                    .setLeading.setTrailing.setHeight.equalTo(signInButtom.get)
            }
        comp.get.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        return comp
    }()
    @objc private func signUpTapped() {
        delegate?.signUpTapped()
    }
    

//  MARK: - PRIVATE AREA
    public func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        backgroundView.add(insideTo: self)
        signInCustomTextTitle.add(insideTo: self)
        emailCustomText.add(insideTo: self)
        emailTextField.add(insideTo: self)
        passwordText.add(insideTo: self)
        passwordTextField.add(insideTo: self)
        rememberSwitch.add(insideTo: self)
        rememberText.add(insideTo: self)
        signInButtom.add(insideTo: self)
        signUpButtom.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        signInCustomTextTitle.applyConstraint()
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
