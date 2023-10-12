//  Created by Alessandro Comparini on 12/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent

class PhoneNumberTableViewCell: UITableViewCell {
    static let identifier = String(describing: PhoneNumberTableViewCell.self)
    
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
                    .setLeading.setTrailing.equalToSafeArea(24)
            }
        return comp
    }()
    
    lazy var phoneNumberTextField: TextFieldBuilder = {
        let comp = TextFieldBuilder()
            .setReadOnly(true)
            .setBackgroundColor(hexColor: "#ffffff")
            .setPadding(8)
            .setText("(53) 98262-0320")
            .setBorder({ build in
                build
                    .setCornerRadius(8)
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
    public func setupCell() {
        
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        phoneNumberLabelText.add(insideTo: self.contentView)
        phoneNumberTextField.add(insideTo: self.contentView)
    }
    
    private func configConstraints() {
        phoneNumberLabelText.applyConstraint()
        phoneNumberTextField.applyConstraint()
    }
    
}
