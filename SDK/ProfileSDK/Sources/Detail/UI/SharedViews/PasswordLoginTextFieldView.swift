//  Created by Alessandro Comparini on 14/09/23.
//

import UIKit
import DesignerSystemSDKComponent
import CustomComponentsSDK


class PasswordLoginTextFieldView: ViewBuilder {
    
    override init() {
        super.init(frame: .zero)
        configure()
    }
    
    lazy var backgroundView: ViewBuilder = {
        let comp = ViewBuilder()
            .setConstraints { build in
                build
                    .setPin.equalToSafeArea
            }
        return comp
    }()
    
    lazy var passwordText: CustomText = {
        let label = CustomText()
            .setText("Senha")
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea
                    .setLeading.setTrailing.equalToSafeArea
            }
        return label
    }()
    
    lazy var passwordTextField: TextFieldPasswordBuilder = {
        let comp = TextFieldPasswordBuilder(paddingRightImage: 8)
//            .setText("123456Aa")
            .setBackgroundColor(hexColor: "#ffffff")
            .setPadding(8)
            .setPlaceHolder("Digite sua senha")
            .setKeyboard({ buid in
                buid
                    .setKeyboardType(.default)
                    .setReturnKeyType(.done)
            })
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(passwordText.get, .bottom, 16)
                    .setLeading.setTrailing.equalToSafeArea
                    .setHeight.equalToConstant(48)
            }
        return comp
    }()
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        backgroundView.add(insideTo: self.get)
        passwordText.add(insideTo: self.get)
        passwordTextField.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        passwordText.applyConstraint()
        passwordTextField.applyConstraint()
    }
}
