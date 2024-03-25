//  Created by Alessandro Comparini on 09/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent


public protocol ProfileSummaryViewDelegate: AnyObject {
    func logoutButtonTapped()
}

public class ProfileSummaryView: UIView {
    public weak var delegate: ProfileSummaryViewDelegate?
    
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
                    .setPin.equalToSuperview
            }
        return comp
    }()
    
    lazy var screenTitle: CustomTextTitle = {
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
    
    lazy var logoutButton: ButtonImageBuilder = {
        let img = ImageViewBuilder(systemName: "escape")
            .setSize(20)
            .setContentMode(.center)
        let btn = ButtonImageBuilder()
            .setImageButton(img)
            .setImageWeight(.bold)
            .setTintColor(UIColor.HEX("#baa0f4", 0.8))
            .setConstraints { build in
                build
                    .setTop.equalTo(screenTitle.get, .top)
                    .setLeading.equalToSafeArea(16)
                    .setWidth.equalToConstant(68)
                    .setHeight.equalToConstant(24)
            }
        btn.get.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return btn
    }()
    @objc private func logoutButtonTapped(_ button: UIButton) {
        delegate?.logoutButtonTapped()
    }
    
    lazy var logoutLabel: CustomText = {
        let view = CustomText()
            .setText("Deslogar")
            .setColor(hexColor: "#baa0f4")
            .setWeight(.medium)
            .setSize(10)
            .setConstraints { build in
                build
                    .setTop.equalTo(logoutButton.get, .bottom, 2)
                    .setHorizontalAlignmentX.equalTo(logoutButton.get)
            }
        return view
    }()
    
    public lazy var tableViewScroll: TableViewBuilder = {
        let comp = TableViewBuilder()
            .setShowsScroll(false, .both)
            .setSeparatorStyle(.none)
            .setBackgroundColor(.clear)
            .setRegisterCell(ProfilePictureTableViewCell.self)
            .setRegisterCell(CPFTableViewCell.self)
            .setRegisterCell(DateOfBirthTableViewCell.self)
            .setRegisterCell(PhoneNumberTableViewCell.self)
            .setRegisterCell(FieldOfWorkTableViewCell.self)
            .setRegisterCell(SummaryAddressTableViewCell.self)
            .setRegisterCell(EditProfileButtonTableViewCell.self)
            .setConstraints { build in
                build
                    .setTop.equalTo(screenTitle.get, .bottom, 16)
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
        screenTitle.add(insideTo: self)
        logoutButton.add(insideTo: self)
        logoutLabel.add(insideTo: self)
        tableViewScroll.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        screenTitle.applyConstraint()
        logoutButton.applyConstraint()
        logoutLabel.applyConstraint()
        tableViewScroll.applyConstraint()
    }
}
