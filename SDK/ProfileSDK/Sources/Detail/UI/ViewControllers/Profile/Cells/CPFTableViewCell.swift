//  Created by Alessandro Comparini on 12/10/23.
//


import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent

import ProfilePresenters

protocol CPFTableViewCellDelegate: AnyObject {
    func cpfTextFieldShouldChangeCharactersIn(_ textField: UITextField, range: NSRange, string: String)
}


class CPFTableViewCell: UITableViewCell {
    static let identifier = String(describing: CPFTableViewCell.self)
    weak var delegate: CPFTableViewCellDelegate?
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
//  MARK: - LAZY AREA
    
    lazy var cpfLabelText: CustomText = {
        let comp = CustomText()
            .setText("CPF")
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
                    .setVerticalAlignmentY.equalTo(cpfLabelText.get)
                    .setLeading.equalTo(cpfLabelText.get, .trailing, 4)
            }
        return comp
    }()

    lazy var cpfTextField: TextFieldBuilder = {
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
                    .setTop.equalTo(cpfLabelText.get, .bottom, 8)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(48)
            }
        return comp
    }()
    
    
//  MARK: - SETUP CELL
    public func setupCell(_ profilePresenterDTO: ProfilePresenterDTO) {
        cpfTextField.setText(profilePresenterDTO.cpf)
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        addElements()
        configConstraints()
        configDelegate()
    }
    
    private func addElements() {
        cpfLabelText.add(insideTo: self.contentView)
        cpfTextField.add(insideTo: self.contentView)
        fieldRequired.add(insideTo: self.contentView)
    }
    
    private func configConstraints() {
        cpfLabelText.applyConstraint()
        cpfTextField.applyConstraint()
        fieldRequired.applyConstraint()
    }
    
    private func configDelegate() {
        cpfTextField.setDelegate(self)
    }


}


//  MARK: - EXTENSTION - UITextFieldDelegate

extension CPFTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        delegate?.cpfTextFieldShouldChangeCharactersIn(textField, range: range, string: string)
        return false
    }
}

