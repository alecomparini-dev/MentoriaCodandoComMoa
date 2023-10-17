//  Created by Alessandro Comparini on 12/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent

class DateOfBirthTableViewCell: UITableViewCell {
    static let identifier = String(describing: DateOfBirthTableViewCell.self)
    
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
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(8)
                    .setLeading.setTrailing.equalToSafeArea(24)
            }
        return comp
    }()
    
    lazy var dateOfBirthTextField: TextFieldBuilder = {
        let comp = TextFieldBuilder()
            .setPlaceHolder("dd/mm/aaaa")
            .setBackgroundColor(hexColor: "#ffffff")
            .setTextColor(hexColor: "#282a36")
            .setPadding(8)
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setMask({ build in
                build
                    .setDateMask()
            })
            .setKeyboard({ build in
                build
                    .setKeyboardType(.numberPad)
                    .setClearButton()
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
    public func setupCell() {
        
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        dateOfBirthLabelText.add(insideTo: self.contentView)
        dateOfBirthTextField.add(insideTo: self.contentView)
    }
    
    private func configConstraints() {
        dateOfBirthLabelText.applyConstraint()
        dateOfBirthTextField.applyConstraint()
    }
    
}
