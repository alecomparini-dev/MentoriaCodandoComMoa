//  Created by Alessandro Comparini on 12/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent

class EditProfileButtonTableViewCell: UITableViewCell {
    static let identifier = String(describing: EditProfileButtonTableViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - LAZY AREA
    lazy var updateProfileButtom: CustomButtonPrimary = {
        let comp = CustomButtonPrimary("Editar Perfil")
            .setConstraints { build in
                build
                    .setHorizontalAlignmentX.equalToSafeArea
                    .setVerticalAlignmentY.equalToSafeArea(-30)
                    .setLeading.setTrailing.equalToSafeArea(44)
                    .setHeight.equalToConstant(48)
            }
        comp.get.addTarget(self, action: #selector(updateProfileTapped), for: .touchUpInside)
        return comp
    }()
    @objc private func updateProfileTapped() {
        
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
        updateProfileButtom.add(insideTo: self.contentView)
    }
    
    private func configConstraints() {
        updateProfileButtom.applyConstraint()
    }
    
}
