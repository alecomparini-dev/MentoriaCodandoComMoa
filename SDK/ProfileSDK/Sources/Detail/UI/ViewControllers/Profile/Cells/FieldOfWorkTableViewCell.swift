//  Created by Alessandro Comparini on 12/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent
import ProfilePresenters


class FieldOfWorkTableViewCell: UITableViewCell {
    static let identifier = String(describing: FieldOfWorkTableViewCell.self)
    
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
            .setSkeleton({ build in
                build
            })
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
    
    
//  MARK: - SETUP CELL
    public func setupCell(_ profilePresenterDTO: ProfilePresenterDTO?) {
        guard let profilePresenterDTO else { return showSkeleton()}
        resetSkeleton()
        fieldOfWorkTextField.setText(profilePresenterDTO.fieldOfWork)
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
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

    private func showSkeleton() {
        fieldOfWorkLabelText.skeleton?.showSkeleton()
        fieldOfWorkTextField.skeleton?.showSkeleton()
    }

    private func resetSkeleton() {
        fieldOfWorkLabelText.skeleton?.hideSkeleton()
        fieldOfWorkTextField.skeleton?.hideSkeleton()
    }
}


