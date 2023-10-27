//  Created by Alessandro Comparini on 25/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent

public protocol AddServiceViewCellDelegate: AnyObject {
    func confirmationButtonTapped()
}

public class AddServiceViewCell: ViewBuilder {
    public weak var delegate: AddServiceViewCellDelegate?
    
    public override init() {
        super.init()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 

//  MARK: - LAZY AREA
    lazy var titleServiceText: CustomText = {
        let comp = CustomText()
            .setText("Título")
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(4)
                    .setLeading.equalToSafeArea(24)
            }
        return comp
    }()
    
    lazy public var titleFieldRequired: FieldRequiredCustomTextSecondary = {
        let comp = FieldRequiredCustomTextSecondary()
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(titleServiceText.get)
                    .setLeading.equalTo(titleServiceText.get, .trailing, 4)
            }
        return comp
    }()
    
    lazy public var titleServiceTextField: TextFieldBuilder = {
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
                    .setTop.equalTo(titleServiceTextField.get, .bottom, 24)
                    .setLeading.equalToSafeArea(24)
            }
        return comp
    }()
    
    lazy public var descriptionFieldRequired: FieldRequiredCustomTextSecondary = {
        let comp = FieldRequiredCustomTextSecondary()
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(descriptionServiceText.get)
                    .setLeading.equalTo(descriptionServiceText.get, .trailing, 4)
            }
        return comp
    }()
    
    lazy public var descriptionServiceTextView: TextViewBuilder = {
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
                    .setLeading.setTrailing.equalTo(titleServiceTextField.get)
                    .setHeight.equalToConstant(120)
            }
        return comp
    }()
    
    
//  MARK: - GROUP VIEW

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
                    .setTop.equalTo(descriptionServiceTextView.get, .bottom, 40)
                    .setLeading.setTrailing.equalTo(titleServiceTextField.get, 24)
                    .setHeight.equalToConstant(140)
            }
        return comp
    }()
    

//  MARK: - DURATION
    lazy var durationServiceText: CustomText = {
        let comp = CustomText()
            .setText("Duração:")
            .setConstraints { build in
                build
                    .setTop.setLeading.equalToSafeArea(32)
                    .setWidth.equalToConstant(80)
            }
        return comp
    }()
    
    lazy public var durationServiceTextField: TextFieldBuilder = {
        let comp = TextFieldBuilder()
            .setBackgroundColor(hexColor: "#ffffff")
            .setTextColor(hexColor: "#282a36")
            .setTextAlignment(.center)
            .setPlaceHolder("min")
            .setPadding(8)
            .setKeyboard({ build in
                build
                    .setKeyboardType(.numberPad)
            })
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

    
//  MARK: - HOW MUTCH
    lazy var howMutchServiceText: CustomText = {
        let comp = CustomText()
            .setText("Valor:")
            .setConstraints { build in
                build
                    .setBottom.setLeading.equalToSafeArea(32)
                    .setWidth.equalTo(durationServiceText.get)
            }
        return comp
    }()
    
    lazy public var howMutchServiceTextField: TextFieldBuilder = {
        let comp = TextFieldBuilder()
            .setBackgroundColor(hexColor: "#ffffff")
            .setTextColor(hexColor: "#282a36")
            .setTextAlignment(.center)
            .setPlaceHolder("R$ 0,00")
            .setPadding(8)
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setKeyboard({ build in
                build
                    .setKeyboardType(.decimalPad)
            })
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(howMutchServiceText.get)
                    .setLeading.equalTo(howMutchServiceText.get, .trailing, 16)
                    .setTrailing.equalToSafeArea(-32)
                    .setHeight.equalToConstant(32)
            }
        return comp
    }()

    
//  MARK: - BUTTOM CONFIRMATION
    lazy var confirmationButtom: CustomButtonPrimary = {
        let comp = CustomButtonPrimary("Salvar")
            .setConstraints { build in
                build
                    .setTop.equalTo(groupView.get, .bottom, 56)
                    .setLeading.setTrailing.equalToSafeArea(44)
                    .setHeight.equalToConstant(48)
            }
        comp.get.addTarget(self, action: #selector(confirmationButtonTapped), for: .touchUpInside)
        return comp
    }()
    @objc private func confirmationButtonTapped() {
        delegate?.confirmationButtonTapped()
    }
    

//  MARK: - PRIVATE AREA
    
    private func configure() {
        setBackgroundColor(hexColor: "#282A35")
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        titleServiceText.add(insideTo: self.get)
        titleFieldRequired.add(insideTo: self.get)
        titleServiceTextField.add(insideTo: self.get)
        descriptionServiceText.add(insideTo: self.get)
        descriptionFieldRequired.add(insideTo: self.get)
        descriptionServiceTextView.add(insideTo: self.get)
        groupView.add(insideTo: self.get)
        durationServiceText.add(insideTo: groupView.get)
        durationServiceTextField.add(insideTo: groupView.get)
        howMutchServiceText.add(insideTo: groupView.get)
        howMutchServiceTextField.add(insideTo: groupView.get)
        confirmationButtom.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        titleServiceText.applyConstraint()
        titleFieldRequired.applyConstraint()
        titleServiceTextField.applyConstraint()
        descriptionServiceText.applyConstraint()
        descriptionFieldRequired.applyConstraint()
        descriptionServiceTextView.applyConstraint()
        groupView.applyConstraint()
        durationServiceText.applyConstraint()
        durationServiceTextField.applyConstraint()
        howMutchServiceText.applyConstraint()
        howMutchServiceTextField.applyConstraint()
        confirmationButtom.applyConstraint()
    }
    
    
}
