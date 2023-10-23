//  Created by Alessandro Comparini on 09/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent


public class ProfileSummaryView: UIView {
    
    public init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - LAZY AREA
    
    lazy var backgroundView: CustomView = {
        let comp = CustomView()
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return comp
    }()
    
    lazy var perfilTextTitle: CustomTextTitle = {
        let comp = CustomTextTitle()
            .setText("Perfil")
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(24)
                    .setLeading.setTrailing.equalToSafeArea(16)
            }
        return comp
    }()
    
    public lazy var tableViewScroll: TableViewBuilder = {
        let comp = TableViewBuilder()
            .setShowsScroll(false, .both)
            .setSeparatorStyle(.none)
            .setBackgroundColor(color: .clear)
            .setRegisterCell(ProfilePictureTableViewCell.self)
            .setRegisterCell(CPFTableViewCell.self)
            .setRegisterCell(DateOfBirthTableViewCell.self)
            .setRegisterCell(PhoneNumberTableViewCell.self)
            .setRegisterCell(FieldOfWorkTableViewCell.self)
            .setRegisterCell(SummaryAddressTableViewCell.self)
            .setRegisterCell(EditProfileButtonTableViewCell.self)
            .setConstraints { build in
                build
                    .setTop.equalTo(perfilTextTitle.get, .bottom, 16)
                    .setPinBottom.equalToSafeArea
            }
        return comp
    }()
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        backgroundView.add(insideTo: self)
        perfilTextTitle.add(insideTo: self)
        tableViewScroll.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        perfilTextTitle.applyConstraint()
        tableViewScroll.applyConstraint()
    }
}
