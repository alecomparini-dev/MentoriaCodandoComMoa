//  Created by Alessandro Comparini on 12/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent
import ProfilePresenters


class PhoneNumberTableViewCell: UITableViewCell {
    static let identifier = String(describing: PhoneNumberTableViewCell.self)
    
    private var phoneNumberLabelSkeleton: SkeletonBuilder?
    private var phoneNumberTextFieldSkeleton: SkeletonBuilder?
    
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
            .setConstraints { build in
                build
                    .setTop.equalTo(phoneNumberLabelText.get, .bottom, 8)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(48)
            }
        return comp
    }()
        
    
//  MARK: - SETUP CELL
    public func setupCell(_ profilePresenterDTO: ProfilePresenterDTO?) {
        guard let profilePresenterDTO else { return applySkeleton()}
        resetSkeleton()
        phoneNumberTextField.setText(profilePresenterDTO.cellPhoneNumber)
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        addElements()
        configConstraints()
        configSkeleton()
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
        
    private func configSkeleton() {
        phoneNumberLabelSkeleton = SkeletonBuilder(component: phoneNumberLabelText).setCornerRadius(4)
        phoneNumberTextFieldSkeleton = SkeletonBuilder(component: phoneNumberTextField)
    }
    
    private func applySkeleton() {
        phoneNumberLabelSkeleton?.showSkeleton()
        phoneNumberTextFieldSkeleton?.showSkeleton()
    }

    private func resetSkeleton() {
        phoneNumberLabelSkeleton?.hideSkeleton()
        phoneNumberTextFieldSkeleton?.hideSkeleton()
    }

}

