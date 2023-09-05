//  Created by Alessandro Comparini on 30/08/23.
//

import UIKit
import DSMComponent
import CustomComponentsSDK


class LoginView: UIView {
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - LAZY AREA
    lazy var customText: CustomText = {
        let label = CustomText()
            .setText("Hello Word, from BackEnd")
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(40)
                    .setLeading.setTrailing.equalToSafeArea(24)
            }
        return label
    }()
    
    lazy var customButtom: CustomButton = {
        let btn = CustomButton("Botão customizado")
            .setConstraints { build in
                build
                    .setTop.equalTo(customText.get, .bottom, 25)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(50)
            }
        return btn
    }()
    
    lazy var customButtomPrimary: CustomButtonPrimary = {
        let btn = CustomButtonPrimary("Botão Primary")
            .setConstraints { build in
                build
                    .setTop.equalTo(customButtom.get, .bottom, 15)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(50)
            }
        return btn
    }()
    
    lazy var buttomSecondary: CustomButtonSecondary = {
        let btn = CustomButtonSecondary("Botão Secondary")
            .setConstraints { build in
                build
                    .setTop.equalTo(customButtomPrimary.get, .bottom, 15)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(50)
            }
        return btn
    }()
    

//  MARK: - PRIVATE AREA
    public func configure() {
        configBackgroundColor()
        addElements()
        configConstraints()
    }
    
    private func configBackgroundColor() {
        self.backgroundColor = UIColor.HEX("#749bc2")
    }
    
    private func addElements() {
        addSubview(customText.get)
        addSubview(customButtom.get)
        addSubview(customButtomPrimary.get)
        addSubview(buttomSecondary.get)
    }
    
    private func configConstraints() {
        customText.applyConstraint()
        customButtom.applyConstraint()
        customButtomPrimary.applyConstraint()
        buttomSecondary.applyConstraint()
    }
    
    
}
