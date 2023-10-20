//  Created by Alessandro Comparini on 12/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent
import ProfilePresenters

protocol FieldOfWorkTableViewCellDelegate: AnyObject {
    func fieldOfWorkTextFieldShouldBeginEditing()
    func fieldOfWorkTextFieldShouldChangeCharactersIn()
}

class FieldOfWorkTableViewCell: UITableViewCell {
    static let identifier = String(describing: FieldOfWorkTableViewCell.self)
    weak var delegate: FieldOfWorkTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - LAZY AREA
    
    lazy var fieldOfWorkLabelText: CustomText = {
        let comp = CustomText()
            .setText("Ramo de atuação")
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
                    .setVerticalAlignmentY.equalTo(fieldOfWorkLabelText.get)
                    .setLeading.equalTo(fieldOfWorkLabelText.get, .trailing, 4)
            }
        return comp
    }()
    
    lazy var fieldOfWorkTextField: TextFieldBuilder = {
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
                    .setTop.equalTo(fieldOfWorkLabelText.get, .bottom, 8)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(48)
            }
        return comp
    }()
    

//  MARK: - PUBLIC AREA
    public func configSkeleton() {
        fieldOfWorkLabelText.setSkeleton { build in
            build
                .showSkeleton(.gradientAnimated)
        }
        fieldOfWorkTextField.setSkeleton { build in
            build
                .showSkeleton(.gradientAnimated)
        }
    }
    
    
//  MARK: - SETUP CELL
    public func setupCell(_ profilePresenterDTO: ProfilePresenterDTO?) {
        guard let profilePresenterDTO else {return}
        resetSkeleton()
        fieldOfWorkTextField.setText(profilePresenterDTO.fieldOfWork)
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        addElements()
        configConstraints()
        configDelegate()
    }
    
    private func addElements() {
        fieldOfWorkLabelText.add(insideTo: self.contentView)
        fieldOfWorkTextField.add(insideTo: self.contentView)
        fieldRequired.add(insideTo: self.contentView)
    }
    
    private func configConstraints() {
        fieldOfWorkLabelText.applyConstraint()
        fieldOfWorkTextField.applyConstraint()
        fieldRequired.applyConstraint()
    }
    
    private func configDelegate() {
        fieldOfWorkTextField.setDelegate(self)
    }
    
    private func resetSkeleton() {
        fieldOfWorkLabelText.get.hideSkeleton()
        fieldOfWorkTextField.get.hideSkeleton()
    }
}

//  MARK: - EXTENSTION - UITextFieldDelegate

extension FieldOfWorkTableViewCell: UITextFieldDelegate {
        
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.fieldOfWorkTextFieldShouldBeginEditing()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        delegate?.fieldOfWorkTextFieldShouldChangeCharactersIn()
        return true
    }
    
}

