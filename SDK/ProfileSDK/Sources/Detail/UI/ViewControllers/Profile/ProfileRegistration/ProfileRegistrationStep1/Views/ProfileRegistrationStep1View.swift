//  Created by Alessandro Comparini on 13/10/23.
//

import UIKit

import DesignerSystemSDKComponent
import CustomComponentsSDK

import ProfilePresenters

protocol ProfileRegistrationStep1ViewDelegate: AnyObject {
    func backButtonTapped()
}


class ProfileRegistrationStep1View: UIView {
    weak var delegate: ProfileRegistrationStep1ViewDelegate?
    
    public var constraintsBottom: NSLayoutConstraint!
    
    init() {
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
    
    lazy var backButton: ButtonImageBuilder = {
        let img = ImageViewBuilder(systemName: "chevron.backward")
            .setContentMode(.center)
        let comp = ButtonImageBuilder()
            .setImageButton(img)
            .setImageColor(hexColor: "#ffffff")
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(24)
                    .setLeading.equalToSafeArea(16)
                    .setSize.equalToConstant(35)
            }
        comp.get.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return comp
    }()
    @objc private func backButtonTapped() {
        delegate?.backButtonTapped()
    }
    
    lazy var stepTextTitle: CustomText = {
        let comp = CustomText()
            .setText("Etapa 1 de 2")
            .setSize(24)
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(backButton.get)
                    .setLeading.setTrailing.equalToSafeArea(16)
            }
        return comp
    }()
    
    lazy var tableViewIdentification: TableViewBuilder = {
        let comp = TableViewBuilder()
            .setShowsScroll(false, .both)
            .setSeparatorStyle(.none)
            .setBackgroundColor(.clear)
            .setRegisterCell(NameTableViewCell.self)
            .setRegisterCell(CPFTableViewCell.self)
            .setRegisterCell(DateOfBirthTableViewCell.self)
            .setRegisterCell(PhoneNumberTableViewCell.self)
            .setRegisterCell(FieldOfWorkTableViewCell.self)
            .setRegisterCell(ContinueRegistrationProfileButtonTableViewCell.self)
            .setConstraints { build in
                build
                    .setTop.equalTo(backButton.get, .bottom, 36)
                    .setLeading.setTrailing.equalToSafeArea
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
        stepTextTitle.add(insideTo: self)
        backButton.add(insideTo: self)
        tableViewIdentification.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        backButton.applyConstraint()
        stepTextTitle.applyConstraint()
        configTableViewIdentificationConstraints()
    }
    
    private func configTableViewIdentificationConstraints() {
        tableViewIdentification.applyConstraint()
        self.constraintsBottom = NSLayoutConstraint(item: self.tableViewIdentification.get,
                                                    attribute: .bottom,
                                                    relatedBy: .equal,
                                                    toItem: self.safeAreaLayoutGuide,
                                                    attribute: .bottom,
                                                    multiplier: 1,
                                                    constant: 0)
        self.constraintsBottom.isActive = true
    }
}
