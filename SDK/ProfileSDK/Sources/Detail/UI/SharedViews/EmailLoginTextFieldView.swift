//  Created by Alessandro Comparini on 14/09/23.
//

import UIKit
import DSMComponent
import CustomComponentsSDK


class EmailLoginTextFieldView: ViewBuilder {
    
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
    
    lazy var emailCustomText: CustomText = {
        let comp = CustomText()
            .setText("E-mail")
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea
                    .setLeading.setTrailing.equalToSafeArea
            }
        return comp
    }()
    
    lazy var emailTextField: TextFieldImageBuilder = {
        let personImg = ImageViewBuilder(systemName: "person")
        let comp = TextFieldImageBuilder("Digite seu e-mail")
            .setImage(personImg, .right, 8)
            .setBackgroundColor(hexColor: "#ffffff")
            .setPadding(8)
            .setKeyboard({ build in
                build
                    .setKeyboardType(.emailAddress)
                    .setReturnKeyType(.continue)
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
