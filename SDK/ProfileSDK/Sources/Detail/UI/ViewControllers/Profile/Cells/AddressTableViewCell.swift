//  Created by Alessandro Comparini on 13/10/23.
//


import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent

class AddressTableViewCell: UITableViewCell {
    static let identifier = String(describing: AddressTableViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
//  MARK: - LAZY AREA
    
    lazy var CEPLabelText: CustomText = {
        let comp = CustomText()
            .setText("CEP")
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(8)
                    .setLeading.setTrailing.equalToSafeArea(24)
            }
        return comp
    }()
    
    lazy var CEPTextField: TextFieldImageBuilder = {
        let img = ImageViewBuilder(systemName: "magnifyingglass")
        let comp = TextFieldImageBuilder()
            .setKeyboard({ build in
                build
                    .setKeyboardType(.numberPad)
            })
            .setImage(img, .right, 8)
            .setBackgroundColor(hexColor: "#ffffff")
            .setTextColor(hexColor: "#282a36")
            .setPadding(8)
            .setPlaceHolder("Pesquisar CEP")
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(CEPLabelText.get, .bottom, 8)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(48)
            }
        return comp
    }()
    
    
    lazy var streetLabelText: CustomText = {
        let comp = CustomText()
            .setText("Rua")
            .setConstraints { build in
                build
                    .setTop.equalTo(CEPTextField.get, .bottom, 24)
                    .setLeading.setTrailing.equalTo(CEPTextField.get)
            }
        return comp
    }()
    
    lazy var streetTextField: TextFieldBuilder = {
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
                    .setTop.equalTo(streetLabelText.get, .bottom, 8)
                    .setLeading.setTrailing.setHeight.equalTo(CEPTextField.get)
            }
        return comp
    }()
    
    
    lazy var numberLabelText: CustomText = {
        let comp = CustomText()
            .setText("Número")
            .setConstraints { build in
                build
                    .setTop.equalTo(streetTextField.get, .bottom, 24)
                    .setLeading.setTrailing.equalTo(CEPTextField.get)
            }
        return comp
    }()
    
    lazy var numberTextField: TextFieldBuilder = {
        let comp = TextFieldBuilder()
            .setKeyboard({ build in
                build
                    .setKeyboardType(.numberPad)
            })
            .setBackgroundColor(hexColor: "#ffffff")
            .setTextColor(hexColor: "#282a36")
            .setPadding(8)
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(numberLabelText.get, .bottom, 8)
                    .setLeading.setTrailing.setHeight.equalTo(CEPTextField.get)
            }
        return comp
    }()

    
    lazy var neighborhoodLabelText: CustomText = {
        let comp = CustomText()
            .setText("Bairro")
            .setConstraints { build in
                build
                    .setTop.equalTo(numberTextField.get, .bottom, 24)
                    .setLeading.setTrailing.equalTo(CEPTextField.get)
            }
        return comp
    }()
    
    lazy var neighborhoodTextField: TextFieldBuilder = {
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
                    .setTop.equalTo(neighborhoodLabelText.get, .bottom, 8)
                    .setLeading.setTrailing.setHeight.equalTo(CEPTextField.get)
            }
        return comp
    }()
    
    
    lazy var cityLabelText: CustomText = {
        let comp = CustomText()
            .setText("Cidade")
            .setConstraints { build in
                build
                    .setTop.equalTo(neighborhoodTextField.get, .bottom, 24)
                    .setLeading.setTrailing.equalTo(CEPTextField.get)
            }
        return comp
    }()
    
    lazy var cityTextField: TextFieldBuilder = {
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
                    .setTop.equalTo(cityLabelText.get, .bottom, 8)
                    .setLeading.setTrailing.setHeight.equalTo(CEPTextField.get)
            }
        return comp
    }()
    
    lazy var stateLabelText: CustomText = {
        let comp = CustomText()
            .setText("Estado")
            .setConstraints { build in
                build
                    .setTop.equalTo(cityTextField.get, .bottom, 24)
                    .setLeading.setTrailing.equalTo(CEPTextField.get)
            }
        return comp
    }()
    
    lazy var stateTextField: TextFieldBuilder = {
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
                    .setTop.equalTo(stateLabelText.get, .bottom, 8)
                    .setLeading.setTrailing.setHeight.equalTo(CEPTextField.get)
            }
        return comp
    }()
    
    
    lazy var confirmationButtom: CustomButtonPrimary = {
        let comp = CustomButtonPrimary("Confirmar")
            .setConstraints { build in
                build
                    .setTop.equalTo(stateTextField.get, .bottom, 72)
                    .setLeading.setTrailing.equalToSafeArea(44)
                    .setHeight.equalToConstant(48)
            }
        comp.get.addTarget(self, action: #selector(confirmationTapped), for: .touchUpInside)
        return comp
    }()
    @objc private func confirmationTapped() {
        
    }
    
    
//  MARK: - SETUP CELL
    public func setupCell() {
        
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        CEPLabelText.add(insideTo: self.contentView)
        CEPTextField.add(insideTo: self.contentView)
        streetLabelText.add(insideTo: self.contentView)
        streetTextField.add(insideTo: self.contentView)
        numberLabelText.add(insideTo: self.contentView)
        numberTextField.add(insideTo: self.contentView)
        neighborhoodLabelText.add(insideTo: self.contentView)
        neighborhoodTextField.add(insideTo: self.contentView)
        cityLabelText.add(insideTo: self.contentView)
        cityTextField.add(insideTo: self.contentView)
        stateLabelText.add(insideTo: self.contentView)
        stateTextField.add(insideTo: self.contentView)
        confirmationButtom.add(insideTo: self.contentView)
    }
    
    private func configConstraints() {
        CEPLabelText.applyConstraint()
        CEPTextField.applyConstraint()
        streetLabelText.applyConstraint()
        streetTextField.applyConstraint()
        numberLabelText.applyConstraint()
        numberTextField.applyConstraint()
        neighborhoodLabelText.applyConstraint()
        neighborhoodTextField.applyConstraint()
        cityLabelText.applyConstraint()
        cityTextField.applyConstraint()
        stateLabelText.applyConstraint()
        stateTextField.applyConstraint()
        confirmationButtom.applyConstraint()
    }
    
    
}
