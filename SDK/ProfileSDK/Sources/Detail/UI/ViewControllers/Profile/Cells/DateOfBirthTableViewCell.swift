//  Created by Alessandro Comparini on 12/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent
import ProfilePresenters


class DateOfBirthTableViewCell: UITableViewCell {
    static let identifier = String(describing: DateOfBirthTableViewCell.self)
    
    private var skeletonLabel: SkeletonBuilder?
    private var skeletonTextField: SkeletonBuilder?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
//  MARK: - LAZY AREA
    lazy var dateOfBirthLabelText: CustomText = {
        let comp = CustomText()
            .setText("Data de nascimento")
            .setSkeleton({ build in
                build.setCornerRadius(4)
            })
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
                    .setVerticalAlignmentY.equalTo(dateOfBirthLabelText.get)
                    .setLeading.equalTo(dateOfBirthLabelText.get, .trailing, 4)
            }
        return comp
    }()
    
    lazy var dateOfBirthTextField: TextFieldBuilder = {
        let comp = TextFieldBuilder()
            .setPlaceHolder("dd/mm/aaaa")
            .setBackgroundColor(hexColor: "#ffffff")
            .setTextColor(hexColor: "#282a36")
            .setPadding(8)
            .setSkeleton({ build in
                build
            })
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
                    .setTop.equalTo(dateOfBirthLabelText.get, .bottom, 8)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(48)
            }
        return comp
    }()

    
//  MARK: - SETUP CELL
    public func setupCell(_ profilePresenterDTO: ProfilePresenterDTO?) {
        guard let profilePresenterDTO else { return showSkeleton() }
        resetSkeleton()
        dateOfBirthTextField.setText(profilePresenterDTO.dateOfBirth)
    }
    

//  MARK: - PRIVATE AREA
    
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        dateOfBirthLabelText.add(insideTo: self.contentView)
        dateOfBirthTextField.add(insideTo: self.contentView)
        fieldRequired.add(insideTo: self.contentView)
    }
    
    private func configConstraints() {
        dateOfBirthLabelText.applyConstraint()
        dateOfBirthTextField.applyConstraint()
        fieldRequired.applyConstraint()
    }
       
    private func showSkeleton() {
        dateOfBirthLabelText.skeleton?.showSkeleton()
        dateOfBirthTextField.skeleton?.showSkeleton()
    }
    
    private func resetSkeleton() {
        dateOfBirthLabelText.skeleton?.hideSkeleton()
        dateOfBirthTextField.skeleton?.hideSkeleton()
    }

    
}

