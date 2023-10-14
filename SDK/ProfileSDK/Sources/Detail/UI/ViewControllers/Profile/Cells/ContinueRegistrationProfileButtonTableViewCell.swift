//  Created by Alessandro Comparini on 12/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent

protocol ContinueRegistrationProfileButtonTableViewCellDelegate: AnyObject {
    func continueRegistrationTapped()
}

class ContinueRegistrationProfileButtonTableViewCell: UITableViewCell {
    static let identifier = String(describing: ContinueRegistrationProfileButtonTableViewCell.self)
    
    weak var delegate: ContinueRegistrationProfileButtonTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - LAZY AREA
    lazy var continueRegistrationButtom: CustomButtonSecondary = {
        let comp = CustomButtonSecondary("Continuar")
            .setConstraints { build in
                build
                    .setHorizontalAlignmentX.equalToSafeArea
                    .setVerticalAlignmentY.equalToSafeArea(-30)
                    .setLeading.setTrailing.equalToSafeArea(44)
                    .setHeight.equalToConstant(48)
            }
        comp.get.addTarget(self, action: #selector(continueRegistrationTapped), for: .touchUpInside)
        return comp
    }()
    @objc private func continueRegistrationTapped() {
        delegate?.continueRegistrationTapped()
    }
    
    
//  MARK: - SETUP CELL
    public func setupCell() {
        
    }
        
        
//  MARK: - PRIVATE AREA
    
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        continueRegistrationButtom.add(insideTo: self.contentView)
    }
    
    private func configConstraints() {
        continueRegistrationButtom.applyConstraint()
    }
    
}
