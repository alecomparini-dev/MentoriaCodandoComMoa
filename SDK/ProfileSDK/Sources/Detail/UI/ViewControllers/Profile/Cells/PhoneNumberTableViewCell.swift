//  Created by Alessandro Comparini on 12/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent
import ProfilePresenters

protocol PhoneNumberTableViewDelegate: AnyObject {
    func cellPhoneTextFieldShouldBeginEditing()
    func cellPhoneTextFieldShouldChangeCharactersIn(_ textField: UITextField, range: NSRange, string: String)
}


class PhoneNumberTableViewCell: UITableViewCell {
    static let identifier = String(describing: PhoneNumberTableViewCell.self)
    weak var delegate: PhoneNumberTableViewDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
//  MARK: - LAZY AREA
    
    lazy var phoneNumberLabelText: CustomText = {
        let comp = CustomText()
            .setText("Telefone")
            .setSkeleton { build in
                build
                    .showSkeleton(.gradientAnimated)
            }
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(8)
                    .setLeading.equalToSafeArea(24)
            }
        return comp
    }()
    
    lazy var fieldRequired: FieldRequiredCustomTextSecondary = {
        let comp = FieldRequiredCustomTextSecondary()
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(phoneNumberLabelText.get)
                    .setLeading.equalTo(phoneNumberLabelText.get, .trailing, 4)
            }
        return comp
    }()
    
    lazy var phoneNumberTextField: TextFieldBuilder = {
        let comp = TextFieldBuilder()
            .setPlaceHolder("(xx) xxxxx-xxxx")
            .setBackgroundColor(hexColor: "#ffffff")
            .setTextColor(hexColor: "#282a36")
            .setPadding(8)
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setKeyboard({ build in
                build
                    .setKeyboardType(.numberPad)
            })
            .setSkeleton { build in
                build
                    .showSkeleton(.gradientAnimated)
            }
            .setConstraints { build in
                build
                    .setTop.equalTo(phoneNumberLabelText.get, .bottom, 8)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(48)
            }
        return comp
    }()
        
    
//  MARK: - SETUP CELL
    public func setupCell(_ profilePresenterDTO: ProfilePresenterDTO) {
        phoneNumberTextField.setText(profilePresenterDTO.cellPhoneNumber)
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        addElements()
        configConstraints()
        configDelegate()
    }
    
    private func addElements() {
        phoneNumberLabelText.add(insideTo: self.contentView)
        phoneNumberTextField.add(insideTo: self.contentView)
        fieldRequired.add(insideTo: self.contentView)
    }
    
    private func configConstraints() {
        phoneNumberLabelText.applyConstraint()
        phoneNumberTextField.applyConstraint()
        fieldRequired.applyConstraint()
    }
    
    private func configDelegate() {
        phoneNumberTextField.setDelegate(self)
    }

    
}

//  MARK: - EXTENSTION - UITextFieldDelegate

extension PhoneNumberTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.cellPhoneTextFieldShouldBeginEditing()
        return true
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        delegate?.cellPhoneTextFieldShouldChangeCharactersIn(textField, range: range, string: string)
        return false
    }
}
