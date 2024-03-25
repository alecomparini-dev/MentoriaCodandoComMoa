//  Created by Alessandro Comparini on 31/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent

protocol ForgotPasswordViewDelegate: AnyObject {
    func backButtonTapped()
    func resetButtonTapped()
}

class ForgotPasswordView: UIView {
    weak var delegate: ForgotPasswordViewDelegate?
    
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
                    .setPin.equalToSuperview
            }
        return comp
    }()
    
    lazy var backButton: ButtonImageBuilder = {
        let img = ImageViewBuilder(systemName: "chevron.backward")
            .setContentMode(.center)
        let comp = ButtonImageBuilder()
            .setImageButton(img)
            .setImageColor(hexColor: "#ffffff")
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(24)
                    .setLeading.equalToSafeArea(16)
                    .setSize.equalToConstant(35)
            }
        comp.get.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return comp
    }()
    @objc private func backButtonTapped() {
        delegate?.backButtonTapped()
    }
    
    lazy var titleScreen: CustomTextTitle = {
        let comp = CustomTextTitle()
            .setText("Redefinir Senha")
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(24)
                    .setLeading.setTrailing.equalToSafeArea(16)
            }
        return comp
    }()
    
    lazy var emailLoginView: EmailLoginTextFieldView = {
        let comp = EmailLoginTextFieldView()
            .setConstraints { build in
                build
                    .setTop.equalTo(titleScreen.get, .bottom, 56)
                    .setLeading.setTrailing.equalTo(titleScreen.get)
                    .setHeight.equalToConstant(80)
            }
        return comp
    }()
    
    lazy var resetutton: CustomButtonPrimary = {
        let comp = CustomButtonPrimary("Redefinir")
            .setConstraints { build in
                build
                    .setTop.equalTo(emailLoginView.get, .bottom, 72)
                    .setLeading.setTrailing.equalToSafeArea(44)
                    .setHeight.equalToConstant(48)
            }
        comp.get.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        return comp
    }()
    @objc private func resetButtonTapped() {
        delegate?.resetButtonTapped()
    }
    
    
    
//  MARK: - PRIVATE AREA
    public func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        backgroundView.add(insideTo: self)
        backButton.add(insideTo: self)
        titleScreen.add(insideTo: self)
        emailLoginView.add(insideTo: self)
        resetutton.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        backButton.applyConstraint()
        titleScreen.applyConstraint()
        emailLoginView.applyConstraint()
        resetutton.applyConstraint()
    }


    
}
