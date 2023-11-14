//  Created by Alessandro Comparini on 25/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent

public protocol SaveServiceViewCellDelegate: AnyObject {
    func confirmationButtonTapped()
}

public class SaveServiceViewCell: ViewBuilder {
    public weak var delegate: SaveServiceViewCellDelegate?

    
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
    
    lazy public var titleServiceFieldRequired: FieldRequiredCustomTextSecondary = {
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
            .setSize(16)
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
                    .setHeight.equalToConstant(140)
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
    
    lazy public var groupServicesFieldRequired: FieldRequiredCustomTextSecondary = {
        let comp = FieldRequiredCustomTextSecondary()
            .setText("*Campos Obrigatórios")
            .setConstraints { build in
                build
                    .setTop.equalTo(groupView.get, .top, -20)
                    .setLeading.equalTo(groupView.get, .leading, 8)
            }
        return comp
    }()
    

//  MARK: - DURATION
    lazy var durationServiceText: CustomText = {
        let comp = CustomText()
            .setText("Duração:")
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(32)
                    .setLeading.equalToSafeArea(24)
                    .setWidth.equalToConstant(80)
            }
        return comp
    }()
    
    lazy public var durationServiceTextField: TextFieldBuilder = {
        let comp = TextFieldBuilder()
            .setBackgroundColor(hexColor: "#ffffff")
            .setTextColor(hexColor: "#282a36")
            .setPlaceHolder("0")
            .setTextAlignment(.center)
            .setPadding(34, .right)
            .setPadding(22, .left)
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
                    .setLeading.equalTo(durationServiceText.get, .trailing, 12)
                    .setTrailing.equalToSafeArea(-32)
                    .setHeight.equalToConstant(32)
            }
        return comp
    }()
    
    lazy var minLabel: LabelBuilder = {
        let comp = LabelBuilder("min")
            .setSize(14)
            .setWeight(.semibold)
            .setBackgroundColor(howMutchServiceTextField.get.backgroundColor)
            .setTextAlignment(.center)
            .setColor(color: howMutchServiceTextField.get.textColor)
            .setConstraints { build in
                build
                    .setBottom.equalTo(durationServiceTextField.get, .bottom , -4)
                    .setTrailing.equalTo(durationServiceTextField.get, .trailing , -2)
                    .setWidth.equalToConstant(32)
            }
        return comp
    }()

    
//  MARK: - HOW MUTCH
    lazy var howMutchServiceText: CustomText = {
        let comp = CustomText()
            .setText("Valor:")
            .setConstraints { build in
                build
                    .setLeading.equalTo(durationServiceText.get, .leading)
                    .setBottom.equalToSafeArea(-32)
                    .setWidth.equalTo(durationServiceText.get)
            }
        return comp
    }()
    
    lazy public var howMutchServiceTextField: TextFieldBuilder = {
        let comp = TextFieldBuilder()
            .setBackgroundColor(hexColor: "#ffffff")
            .setTextColor(hexColor: "#282a36")
            .setTextAlignment(.center)
            .setPlaceHolder("0,00")
            .setPadding(32, .left)
            .setPadding(12, .right)
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
                    .setLeading.equalTo(howMutchServiceText.get, .trailing, 12)
                    .setTrailing.equalToSafeArea(-32)
                    .setHeight.equalToConstant(32)
            }
        return comp
    }()
    
    lazy var currencySymbolLabel: LabelBuilder = {
        let comp = LabelBuilder("R$")
            .setSize(16)
            .setWeight(.semibold)
            .setBackgroundColor(howMutchServiceTextField.get.backgroundColor)
            .setTextAlignment(.center)
            .setColor(color: howMutchServiceTextField.get.textColor)
            .setConstraints { build in
                build
                    .setPinLeft.equalTo(howMutchServiceTextField.get, 4)
                    .setVerticalAlignmentY.equalTo(howMutchServiceTextField.get)
                    .setWidth.equalToConstant(28)
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
        titleServiceFieldRequired.add(insideTo: self.get)
        titleServiceTextField.add(insideTo: self.get)
        descriptionServiceText.add(insideTo: self.get)
        descriptionFieldRequired.add(insideTo: self.get)
        descriptionServiceTextView.add(insideTo: self.get)
        groupView.add(insideTo: self.get)
        groupServicesFieldRequired.add(insideTo: self.get)
        
        durationServiceText.add(insideTo: groupView.get)
        durationServiceTextField.add(insideTo: groupView.get)
        minLabel.add(insideTo: groupView.get)
        
        howMutchServiceText.add(insideTo: groupView.get)
        howMutchServiceTextField.add(insideTo: groupView.get)
        currencySymbolLabel.add(insideTo: self.get)
        
        confirmationButtom.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        titleServiceText.applyConstraint()
        titleServiceFieldRequired.applyConstraint()
        titleServiceTextField.applyConstraint()
        descriptionServiceText.applyConstraint()
        descriptionFieldRequired.applyConstraint()
        descriptionServiceTextView.applyConstraint()
        groupView.applyConstraint()
        groupServicesFieldRequired.applyConstraint()
        durationServiceText.applyConstraint()
        durationServiceTextField.applyConstraint()
        minLabel.applyConstraint()
        howMutchServiceText.applyConstraint()
        howMutchServiceTextField.applyConstraint()
        currencySymbolLabel.applyConstraint()
        confirmationButtom.applyConstraint()
    }
    
    
}
