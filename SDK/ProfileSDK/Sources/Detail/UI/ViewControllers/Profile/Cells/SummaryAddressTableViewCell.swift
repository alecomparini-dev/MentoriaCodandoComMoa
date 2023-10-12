//  Created by Alessandro Comparini on 12/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent

class SummaryAddressTableViewCell: UITableViewCell {
    static let identifier = String(describing: SummaryAddressTableViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

//  MARK: - LAZY AREA
    
    lazy var summaryAddressText: CustomText = {
        let comp = CustomText()
            .setText("Endereço")
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(8)
                    .setLeading.setTrailing.equalToSafeArea(24)
            }
        return comp
    }()
    
    lazy var summaryAddressTextView: TextViewBuilder = {
        let comp = TextViewBuilder()
            .setInsertText("Rua 29 Quadra 11 Casa 12\n")
            .setInsertText("719092-831\n")
            .setInsertText("Brasília-DF")
            .setSize(17)
            .setLineSpacing(10)
            .setReadOnly(true)
            .setBackgroundColor(hexColor: "#ffffff")
            .setPadding(left: 8, top: 16)
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(summaryAddressText.get, .bottom, 8)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setBottom.equalToSafeArea(-8)
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
        summaryAddressText.add(insideTo: self.contentView)
        summaryAddressTextView.add(insideTo: self.contentView)
    }
    
    private func configConstraints() {
        summaryAddressText.applyConstraint()
        summaryAddressTextView.applyConstraint()
    }
    
}
