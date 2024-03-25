//  Created by Alessandro Comparini on 12/09/23.
//

import UIKit
import CustomComponentsSDK
import DesignerSystemSDKComponent

class TestThemeView: UIView {
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
//  MARK: - LAZY AREA
    
    lazy var backgroundView: CustomView = {
        let view = CustomView()
            .setConstraints { build in
                build
                    .setPin.equalToSuperview
            }
        return view
    }()
    
    lazy var selectThemeLabel: CustomText = {
        let label = CustomText()
                .setText("Selecione um Tema:")
                .setTextAlignment(.center)
                .setConstraints { build in
                    build
                        .setTop.equalToSafeArea(35)
                        .setLeading.setTrailing.equalToSafeArea(24)
                }
        return label
    }()
    
    
    lazy var popUpSelectTheme: ButtonBuilder = {
        let btn = ButtonBuilder("Ligth")
            .setTitleSize(20)
            .setConstraints { build in
                build
                    .setTop.equalTo(selectThemeLabel.get, .bottom, 15)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(40)
            }
        btn.get.setImage(UIImage(systemName: "chevron.up.chevron.down"), for: .normal)
        btn.get.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 70)
        btn.get.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -70)
        return btn
    }()
    
    lazy var themeSelected: CustomText = {
        let label = CustomText()
            .setText("Voce selecionou: Light")
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalTo(popUpSelectTheme.get, .bottom, 15)
                    .setLeading.setTrailing.equalToSafeArea(24)
            }
        return label
    }()
    
    lazy var customText: CustomText = {
        let label = CustomText()
            .setText("Hello Word, from BackEnd")
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalTo(themeSelected.get, .bottom, 45)
                    .setLeading.setTrailing.equalToSafeArea(24)
            }
        return label
    }()
    
    lazy var localText: LabelBuilder = {
        let label = LabelBuilder()
            .setText("Local Font Style Italic")
            .setColor(hexColor: "#ffffff")
            .setSize(27)
            .setItalicFont()
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalTo(customText.get, .bottom, 25)
                    .setLeading.setTrailing.equalToSafeArea(24)
            }
        return label
    }()
    
    
    lazy var customButton: CustomButton = {
        let btn = CustomButton("Botão customizado")
            .setConstraints { build in
                build
                    .setTop.equalTo(localText.get, .bottom, 20)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(50)
            }
        return btn
    }()

    
    
    lazy var customButtomPrimary: CustomButtonPrimary = {
        let btn = CustomButtonPrimary("Botão Primary")
            .setConstraints { build in
                build
                    .setTop.equalTo(customButton.get, .bottom, 10)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(50)
            }
        return btn
    }()
    
    lazy var buttomSecondary: CustomButtonSecondary = {
        let btn = CustomButtonSecondary("Botão Secondary")
            .setConstraints { build in
                build
                    .setTop.equalTo(customButtomPrimary.get, .bottom, 10)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(50)
            }
        return btn
    }()
    
    lazy var buttomThin: ButtonBuilder = {
        let btn = ButtonBuilder("Botão Style Thin")
            .setBackgroundColor(named: "background")
            .setTitleColor(named: "label")
            .setAlpha(0.8)
            .setTitleWeight(.thin)
            .setTitleSize(22)
            .setBorder({ build in
                build
                    .setCornerRadius(12)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(buttomSecondary.get, .bottom, 10)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(50)
            }
        return btn
    }()
    

//  MARK: - PRIVATE AREA
    public func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        addSubview(backgroundView.get)
        addSubview(selectThemeLabel.get)
        addSubview(popUpSelectTheme.get)
        addSubview(themeSelected.get)
        addSubview(customText.get)
        addSubview(localText.get)
        addSubview(customButton.get)
        addSubview(customButtomPrimary.get)
        addSubview(buttomSecondary.get)
        addSubview(buttomThin.get)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        selectThemeLabel.applyConstraint()
        popUpSelectTheme.applyConstraint()
        themeSelected.applyConstraint()
        customText.applyConstraint()
        localText.applyConstraint()
        customButton.applyConstraint()
        customButtomPrimary.applyConstraint()
        buttomSecondary.applyConstraint()
        buttomThin.applyConstraint()
    }
    
    
}
