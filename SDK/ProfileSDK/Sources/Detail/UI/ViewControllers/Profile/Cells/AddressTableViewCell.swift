//  Created by Alessandro Comparini on 13/10/23.
//


import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent
import ProfilePresenters

protocol AddressTableViewCellDelegate: AnyObject {
    func confirmationTapped()
    func searchCEPTapped(_ textField: TextFieldBuilder? ,_ cep: String)
    func textFieldShouldChangeCharactersIn(_ fieldRequired: AddressTableViewCell.FieldRequired, range: NSRange, string: String)
}

class AddressTableViewCell: UITableViewCell {
    static let identifier = String(describing: AddressTableViewCell.self)
    weak var delegate: AddressTableViewCellDelegate?
    
    enum FieldRequired {
        case searchCEP
        case number
    }

//  MARK: - INITIALIZERS
    
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
                    .setLeading.equalToSafeArea(24)
            }
        return comp
    }()
    
    lazy var CEPFieldRequired: FieldRequiredCustomTextSecondary = {
        let comp = FieldRequiredCustomTextSecondary()
            .setHidden(false)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(CEPLabelText.get)
                    .setLeading.equalTo(CEPLabelText.get, .trailing, 4)
            }
        return comp
    }()
    
    lazy var searchCEPTextField: TextFieldImageBuilder = {
        let img = ImageViewBuilder(systemName: "magnifyingglass")
            .setSize(24)
        let comp = TextFieldImageBuilder()
            .setImage(img, .right, 8)
            .setBackgroundColor(hexColor: "#ffffff")
            .setTextColor(hexColor: "#282a36")
            .setPadding(8)
            .setPlaceHolder("Pesquisar CEP")
            .setKeyboard({ build in
                build
                    .setKeyboardType(.numberPad)
            })
            .setMask({ build in
                build
                    .setCEPMask()
            })
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
            .setActions(imagePosition: .right) { build in
                build
                    .setTap { [weak self] _, _  in
                        self?.delegate?.searchCEPTapped (
                            self?.searchCEPTextField,
                            self?.searchCEPTextField.get.text ?? "")
                    }
            }
        return comp
    }()
    
    lazy var loading: LoadingBuilder = {
        let comp = LoadingBuilder()
            .setBackgroundColor(color: searchCEPTextField.get.backgroundColor)
            .setColor(color: UIColor.HEX("#000000", 0.8))
            .setHideWhenStopped(true)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(searchCEPTextField.get)
                    .setTrailing.equalTo(searchCEPTextField.get, .trailing, -4 )
                    .setHeight.setWidth.equalToConstant(35)
            }
        return comp
    }()
    
    
    //  MARK: - STREET
    lazy var streetLabelText: CustomText = {
        let comp = CustomText()
            .setText("Rua")
            .setConstraints { build in
                build
                    .setTop.equalTo(searchCEPTextField.get, .bottom, 24)
                    .setLeading.setTrailing.equalTo(searchCEPTextField.get)
            }
        return comp
    }()
    
    lazy var streetTextField: TextFieldBuilder = {
        let comp = TextFieldBuilder()
            .setReadOnly(true)
            .setBackgroundColor(hexColor: "#cccccc")
            .setTextColor(hexColor: "#282a36")
            .setPadding(8)
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(streetLabelText.get, .bottom, 8)
                    .setLeading.setTrailing.setHeight.equalTo(searchCEPTextField.get)
            }
        return comp
    }()
    
    
    //  MARK: - NUMBER
    lazy var numberLabelText: CustomText = {
        let comp = CustomText()
            .setText("Número")
            .setConstraints { build in
                build
                    .setTop.equalTo(streetTextField.get, .bottom, 24)
                    .setLeading.equalTo(searchCEPTextField.get, .leading)
            }
        return comp
    }()
    
    lazy var numberFieldRequired: FieldRequiredCustomTextSecondary = {
        let comp = FieldRequiredCustomTextSecondary()
            .setHidden(false)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(numberLabelText.get)
                    .setLeading.equalTo(numberLabelText.get, .trailing, 4)
            }
        return comp
    }()
    
    lazy var numberTextField: TextFieldBuilder = {
        let comp = TextFieldBuilder()
            .setBackgroundColor(hexColor: "#ffffff")
            .setTextColor(hexColor: "#282a36")
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
                    .setTop.equalTo(numberLabelText.get, .bottom, 8)
                    .setLeading.setTrailing.setHeight.equalTo(searchCEPTextField.get)
            }
        return comp
    }()

    
    //  MARK: - NEIGHBORHOOD
    lazy var neighborhoodLabelText: CustomText = {
        let comp = CustomText()
            .setText("Bairro")
            .setConstraints { build in
                build
                    .setTop.equalTo(numberTextField.get, .bottom, 24)
                    .setLeading.setTrailing.equalTo(searchCEPTextField.get)
            }
        return comp
    }()
    
    lazy var neighborhoodTextField: TextFieldBuilder = {
        let comp = TextFieldBuilder()
            .setReadOnly(true)
            .setBackgroundColor(hexColor: "#cccccc")
            .setTextColor(hexColor: "#282a36")
            .setPadding(8)
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(neighborhoodLabelText.get, .bottom, 8)
                    .setLeading.setTrailing.setHeight.equalTo(searchCEPTextField.get)
            }
        return comp
    }()
    
    
    //  MARK: - CITY
    lazy var cityLabelText: CustomText = {
        let comp = CustomText()
            .setText("Cidade")
            .setConstraints { build in
                build
                    .setTop.equalTo(neighborhoodTextField.get, .bottom, 24)
                    .setLeading.setTrailing.equalTo(searchCEPTextField.get)
            }
        return comp
    }()
    
    lazy var cityTextField: TextFieldBuilder = {
        let comp = TextFieldBuilder()
            .setReadOnly(true)
            .setBackgroundColor(hexColor: "#cccccc")
            .setTextColor(hexColor: "#282a36")
            .setPadding(8)
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(cityLabelText.get, .bottom, 8)
                    .setLeading.setTrailing.setHeight.equalTo(searchCEPTextField.get)
            }
        return comp
    }()
    
    
    //  MARK: - STATE
    lazy var stateLabelText: CustomText = {
        let comp = CustomText()
            .setText("Estado")
            .setConstraints { build in
                build
                    .setTop.equalTo(cityTextField.get, .bottom, 24)
                    .setLeading.setTrailing.equalTo(searchCEPTextField.get)
            }
        return comp
    }()
    
    lazy var stateTextField: TextFieldBuilder = {
        let comp = TextFieldBuilder()
            .setReadOnly(true)
            .setBackgroundColor(hexColor: "#cccccc")
            .setTextColor(hexColor: "#282a36")
            .setPadding(8)
            .setAutoCapitalization(.allCharacters)
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setMask({ build in
                build
                    .setCustomMask("**")
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(stateLabelText.get, .bottom, 8)
                    .setLeading.setTrailing.setHeight.equalTo(searchCEPTextField.get)
            }
        return comp
    }()
    
    
    //  MARK: - BUTTOM CONFIRMATION
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
        delegate?.confirmationTapped()
    }
    
    
//  MARK: - SETUP CELL
    public func setupCell(_ profilePresenterDTO: ProfilePresenterDTO) {
        cityTextField.setText(profilePresenterDTO.name)
        searchCEPTextField.setText(profilePresenterDTO.cellPhoneNumber)
        neighborhoodTextField.setText(profilePresenterDTO.fieldOfWork)
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        addElements()
        configConstraints()
        configDelegate()
    }
    
    private func addElements() {
        CEPLabelText.add(insideTo: self.contentView)
        CEPFieldRequired.add(insideTo: self.contentView)
        searchCEPTextField.add(insideTo: self.contentView)
        streetLabelText.add(insideTo: self.contentView)
        streetTextField.add(insideTo: self.contentView)
        numberLabelText.add(insideTo: self.contentView)
        numberFieldRequired.add(insideTo: self.contentView)
        numberTextField.add(insideTo: self.contentView)
        neighborhoodLabelText.add(insideTo: self.contentView)
        neighborhoodTextField.add(insideTo: self.contentView)
        cityLabelText.add(insideTo: self.contentView)
        cityTextField.add(insideTo: self.contentView)
        stateLabelText.add(insideTo: self.contentView)
        stateTextField.add(insideTo: self.contentView)
        confirmationButtom.add(insideTo: self.contentView)
        loading.add(insideTo: self.contentView)
    }
    
    private func configConstraints() {
        CEPLabelText.applyConstraint()
        CEPFieldRequired.applyConstraint()
        searchCEPTextField.applyConstraint()
        streetLabelText.applyConstraint()
        streetTextField.applyConstraint()
        numberLabelText.applyConstraint()
        numberFieldRequired.applyConstraint()
        numberTextField.applyConstraint()
        neighborhoodLabelText.applyConstraint()
        neighborhoodTextField.applyConstraint()
        cityLabelText.applyConstraint()
        cityTextField.applyConstraint()
        stateLabelText.applyConstraint()
        stateTextField.applyConstraint()
        confirmationButtom.applyConstraint()
        loading.applyConstraint()
    }
    
    private func configDelegate() {
        searchCEPTextField.setDelegate(self)
        numberTextField.setDelegate(self)
    }

    
    
}


//  MARK: - EXTENSTION - UITextFieldDelegate

extension AddressTableViewCell: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if searchCEPTextField.get.isFirstResponder {
            delegate?.textFieldShouldChangeCharactersIn(FieldRequired.searchCEP, range: range, string: string)
            return false
        }
        
        if numberTextField.get.isFirstResponder {
            delegate?.textFieldShouldChangeCharactersIn(FieldRequired.number, range: range, string: string)
        }
        
        return true
        
    }
}

