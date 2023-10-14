//  Created by Alessandro Comparini on 12/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent

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
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(8)
                    .setLeading.setTrailing.equalToSafeArea(24)
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
    

//  MARK: - SETUP CELL
    public func setupCell() {
        
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        fieldOfWorkLabelText.add(insideTo: self.contentView)
        fieldOfWorkTextField.add(insideTo: self.contentView)
    }
    
    private func configConstraints() {
        fieldOfWorkLabelText.applyConstraint()
        fieldOfWorkTextField.applyConstraint()
    }
}
