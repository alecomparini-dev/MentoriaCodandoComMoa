//  Created by Alessandro Comparini on 24/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent

public protocol AddServiceViewDelegate: AnyObject {
    func backButtonTapped()
}

public class AddServiceView: UIView {
    public weak var delegate: AddServiceViewDelegate?
    
    public init() {
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
    
    lazy var textTitle: CustomTextTitle = {
        let comp = CustomTextTitle()
            .setText("Cadastrar Serviço")
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
            .setContentMode(.center)
        let comp = ButtonImageBuilder()
            .setImageButton(img)
            .setImageColor(hexColor: "#ffffff")
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(textTitle.get)
                    .setLeading.equalToSafeArea(16)
                    .setSize.equalToConstant(35)
            }
        comp.get.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return comp
    }()
    @objc private func backButtonTapped() {
        delegate?.backButtonTapped()
    }
    
    
//  MARK: - TITLE
    lazy var titleServiceText: CustomText = {
        let comp = CustomText()
            .setText("Título")
            .setConstraints { build in
                build
                    .setTop.equalTo(textTitle.get, .bottom, 40)
                    .setLeading.equalToSafeArea(24)
            }
        return comp
    }()
    
    lazy var titleFieldRequired: FieldRequiredCustomTextSecondary = {
        let comp = FieldRequiredCustomTextSecondary()
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(titleServiceText.get)
                    .setLeading.equalTo(titleServiceText.get, .trailing, 4)
            }
        return comp
    }()
    
    lazy var titleTextField: TextFieldBuilder = {
        let comp = TextFieldBuilder()
            .setBackgroundColor(hexColor: "#ffffff")
            .setTextColor(hexColor: "#282a36")
            .setPadding(8)
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(titleServiceText.get, .bottom, 8)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(48)
            }
        return comp
    }()
    
    
//  MARK: - DESCRIPTION SERVICE
    lazy var descriptionServiceText: CustomText = {
        let comp = CustomText()
            .setText("Descrição")
            .setConstraints { build in
                build
                    .setTop.equalTo(titleTextField.get, .bottom, 24)
                    .setLeading.equalToSafeArea(24)
            }
        return comp
    }()
    
    lazy var descriptionFieldRequired: FieldRequiredCustomTextSecondary = {
        let comp = FieldRequiredCustomTextSecondary()
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(descriptionServiceText.get)
                    .setLeading.equalTo(descriptionServiceText.get, .trailing, 4)
            }
        return comp
    }()
    
    lazy var descriptionTextView: TextViewBuilder = {
        let comp = TextViewBuilder()
            .setBackgroundColor(hexColor: "#ffffff")
            .setTextColor(hexColor: "#282a36")
            .setSize(17)
            .setLineSpacing(10)
            .setPadding(left: 8, top: 16)
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(descriptionServiceText.get, .bottom, 8)
                    .setLeading.setTrailing.equalTo(titleTextField.get)
                    .setHeight.equalToConstant(120)
            }
        return comp
    }()
    
    
//  MARK: - DURATION AND HOWMUTCH

    lazy var groupView: ViewBuilder = {
        let comp = ViewBuilder()
            .setBorder { build in
                build
                    .setCornerRadius(12)
                    .setWidth(0.5)
                    .setColor(hexColor: "#B281EB")
            }
            .setConstraints { build in
                build
                    .setTop.equalTo(descriptionTextView.get, .bottom, 48)
                    .setLeading.setTrailing.equalTo(titleTextField.get, 24)
                    .setHeight.equalToConstant(130)
            }
        return comp
    }()

    lazy var durationServiceText: CustomText = {
        let comp = CustomText()
            .setText("Duração")
            .setConstraints { build in
                build
                    .setTop.setLeading.equalToSafeArea(32)
                    .setWidth.equalToConstant(80)
            }
        return comp
    }()
    
    lazy var durationTextField: TextFieldBuilder = {
        let comp = TextFieldBuilder()
            .setBackgroundColor(hexColor: "#ffffff")
            .setTextColor(hexColor: "#282a36")
            .setTextAlignment(.center)
            .setPlaceHolder("00 : 00")
            .setPadding(8)
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(durationServiceText.get)
                    .setLeading.equalTo(durationServiceText.get, .trailing, 16)
                    .setTrailing.equalToSafeArea(-32)
                    .setHeight.equalToConstant(32)
            }
        return comp
    }()
    
    
//  MARK: - BUTTOM CONFIRMATION
    lazy var confirmationButtom: CustomButtonPrimary = {
        let comp = CustomButtonPrimary("Cadastrar")
            .setConstraints { build in
                build
                    .setTop.equalTo(groupView.get, .bottom, 56)
                    .setLeading.setTrailing.equalToSafeArea(44)
                    .setHeight.equalToConstant(48)
            }
        comp.get.addTarget(self, action: #selector(confirmationTapped), for: .touchUpInside)
        return comp
    }()
    @objc private func confirmationTapped() {
//        delegate?.confirmationTapped()
    }
    

//  MARK: - PRIVATE AREA
    
    private func configure() {
        setBackgroundColor(hexColor: "#282A35")
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        backgroundView.add(insideTo: self)
        backButton.add(insideTo: self)
        textTitle.add(insideTo: self)
        titleServiceText.add(insideTo: self)
        titleFieldRequired.add(insideTo: self)
        titleTextField.add(insideTo: self)
        descriptionServiceText.add(insideTo: self)
        descriptionFieldRequired.add(insideTo: self)
        descriptionTextView.add(insideTo: self)
        
        groupView.add(insideTo: self)
        durationServiceText.add(insideTo: groupView.get)
        durationTextField.add(insideTo: groupView.get)
        
        confirmationButtom.add(insideTo: self)
        
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        backButton.applyConstraint()
        textTitle.applyConstraint()
        titleServiceText.applyConstraint()
        titleFieldRequired.applyConstraint()
        titleTextField.applyConstraint()
        descriptionServiceText.applyConstraint()
        descriptionFieldRequired.applyConstraint()
        descriptionTextView.applyConstraint()
        
        groupView.applyConstraint()
        durationServiceText.applyConstraint()
        durationTextField.applyConstraint()
        
        confirmationButtom.applyConstraint()
    }
    
    
}
