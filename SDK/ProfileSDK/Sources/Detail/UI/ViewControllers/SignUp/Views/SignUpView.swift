
//  Created by Alessandro Comparini on 30/08/23.
//

import UIKit
import DSMComponent
import CustomComponentsSDK

protocol SignUpViewDelegate: AnyObject {
    func backButtonTapped()
    func signUpButtonTapped()
}

class SignUpView: UIView {
    weak var delegate: SignUpViewDelegate?
    
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

    lazy var siginUpCustomTextTitle: CustomTextTitle = {
        let comp = CustomTextTitle()
            .setText("Cadastro")
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(24)
                    .setLeading.setTrailing.equalToSafeArea(16)
            }
        return comp
    }()
    
    lazy var backButton: ButtonImageBuilder = {
        let img = ImageViewBuilder(systemName: "chevron.backward")
        let btn = ButtonImageBuilder()
            .setImageButton(img)
            .setImageColor(hexColor: "#ffffff")
            .setConstraints { build in
                build
                    .setLeading.equalToSafeArea(16)
                    .setVerticalAlignmentY.equalTo(siginUpCustomTextTitle.get)
                    .setHeight.setWidth.equalToConstant(40)
            }
        btn.get.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return btn
    }()
    @objc private func backButtonTapped() {
        delegate?.backButtonTapped()
    }
    
    lazy var emailCustomText: CustomText = {
        let comp = CustomText()
            .setText("Email:")
            .setConstraints { build in
                build
                    .setTop.equalTo(siginUpCustomTextTitle.get, .bottom, 56)
                    .setLeading.setTrailing.equalTo(siginUpCustomTextTitle.get)
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
                    .setLeading.setTrailing.equalTo(siginUpCustomTextTitle.get)
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
    
    lazy var confirmationPasswordText: CustomText = {
        let label = CustomText()
            .setText("Confirmação Senha")
            .setConstraints { build in
                build
                    .setTop.equalTo(passwordTextField.get, .bottom, 24)
                    .setLeading.setTrailing.equalTo(emailCustomText.get)
            }
        return label
    }()
    
    lazy var confirmationPasswordTextField: TextFieldPasswordBuilder = {
        let comp = TextFieldPasswordBuilder(paddingRightImage: 8)
            .setBackgroundColor(hexColor: "#ffffff")
            .setPadding(8)
            .setPlaceHolder("Confirmar senha")
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
                    .setTop.equalTo(confirmationPasswordText.get, .bottom, 16)
                    .setLeading.setTrailing.equalTo(passwordTextField.get)
                    .setHeight.equalToConstant(48)
            }
        return comp
    }()
    
    lazy var signUpButtom: CustomButtonSecondary = {
        let comp = CustomButtonSecondary("Cadastrar")
            .setConstraints { build in
                build
                    .setTop.equalTo(confirmationPasswordTextField.get, .bottom, 48)
                    .setLeading.setTrailing.equalToSafeArea(44)
                    .setHeight.equalToConstant(48)
            }
        comp.get.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return comp
    }()
    @objc private func signUpButtonTapped() {
        delegate?.signUpButtonTapped()
    }
    
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        backgroundView.add(insideTo: self)
        siginUpCustomTextTitle.add(insideTo: self)
        backButton.add(insideTo: self)
        emailCustomText.add(insideTo: self)
        emailTextField.add(insideTo: self)
        passwordText.add(insideTo: self)
        passwordTextField.add(insideTo: self)
        confirmationPasswordText.add(insideTo: self)
        confirmationPasswordTextField.add(insideTo: self)
        signUpButtom.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        siginUpCustomTextTitle.applyConstraint()
        backButton.applyConstraint()
        emailCustomText.applyConstraint()
        emailTextField.applyConstraint()
        passwordText.applyConstraint()
        passwordTextField.applyConstraint()
        confirmationPasswordText.applyConstraint()
        confirmationPasswordTextField.applyConstraint()
        signUpButtom.applyConstraint()
    }
    
    
}
