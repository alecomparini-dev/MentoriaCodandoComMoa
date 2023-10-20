//  Created by Alessandro Comparini on 12/10/23.
//
import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent
import ProfilePresenters


protocol NameTableViewCellDelegate: AnyObject {
    func nameTextFieldShouldChangeCharactersIn()
}

class NameTableViewCell: UITableViewCell {
    static let identifier = String(describing: NameTableViewCell.self)
    weak var delegate: NameTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
//  MARK: - LAZY AREA
    
    lazy var nameLabelText: CustomText = {
        let comp = CustomText()
            .setText("Nome Completo")
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
                    .setVerticalAlignmentY.equalTo(nameLabelText.get)
                    .setLeading.equalTo(nameLabelText.get, .trailing, 4)
            }
        return comp
    }()
    
    lazy var nameTextField: TextFieldBuilder = {
        let comp = TextFieldBuilder()
            .setBackgroundColor(hexColor: "#ffffff")
            .setTextColor(hexColor: "#282a36")
            .setPadding(8)
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setAutoCapitalization(.words)
            .setConstraints { build in
                build
                    .setTop.equalTo(nameLabelText.get, .bottom, 8)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(48)
            }
        return comp
    }()
    
    
//  MARK: - SETUP CELL
    public func setupCell(_ profilePresenterDTO: ProfilePresenterDTO?) {
        guard let profilePresenterDTO else {return}
        nameTextField.setText(profilePresenterDTO.name)
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        addElements()
        configConstraints()
        configDelegate()
    }
    
    private func addElements() {
        nameLabelText.add(insideTo: self.contentView)
        nameTextField.add(insideTo: self.contentView)
        fieldRequired.add(insideTo: self.contentView)
    }
    
    private func configConstraints() {
        nameLabelText.applyConstraint()
        nameTextField.applyConstraint()
        fieldRequired.applyConstraint()
    }
    
    private func configDelegate() {
        nameTextField.setDelegate(self)
    }
    
}


//  MARK: - EXTENSTION - UITextFieldDelegate

extension NameTableViewCell: UITextFieldDelegate {
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        delegate?.nameTextFieldShouldChangeCharactersIn()
        return true
    }
    
    
}


