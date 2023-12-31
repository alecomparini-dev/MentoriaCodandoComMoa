//  Created by Alessandro Comparini on 14/09/23.
//

import UIKit
import DesignerSystemSDKComponent
import CustomComponentsSDK


class EmailLoginTextFieldView: ViewBuilder {
    
    override init() {
        super.init(frame: .zero)
        configure()
    }
    
    
//  MARK: - LAZY AREA
    
    lazy var backgroundView: ViewBuilder = {
        let comp = ViewBuilder()
            .setConstraints { build in
                build
                    .setPin.equalToSafeArea
            }
        return comp
    }()
    
    lazy var emailCustomText: CustomText = {
        let comp = CustomText()
            .setText("E-mail")
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea
                    .setLeading.equalToSafeArea
            }
        return comp
    }()
    
    lazy var emailTextField: TextFieldImageBuilder = {
        let personImg = ImageViewBuilder(systemName: "person")
        let comp = TextFieldImageBuilder("Digite seu e-mail")
            .setImage(personImg, .right, 8)
            .setAutoCapitalization(.none)
            .setBackgroundColor(hexColor: "#ffffff")
            .setPadding(8)
            .setKeyboard({ build in
                build
                    .setKeyboardType(.emailAddress)
            })
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(emailCustomText.get, .bottom, 16)
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
        emailCustomText.add(insideTo: self.get)
        emailTextField.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        emailCustomText.applyConstraint()
        emailTextField.applyConstraint()
    }
    
}
