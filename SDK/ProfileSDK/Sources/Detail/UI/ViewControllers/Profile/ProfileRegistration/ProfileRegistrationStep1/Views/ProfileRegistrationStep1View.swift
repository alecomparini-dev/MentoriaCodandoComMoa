//  Created by Alessandro Comparini on 13/10/23.
//

import UIKit

import DesignerSystemSDKComponent
import CustomComponentsSDK

class ProfileRegistrationStep1View: UIView {
    
    
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
                    .setPin.equalToSuperView
            }
        return comp
    }()
    
    lazy var backButton: ButtonImageBuilder = {
        let img = ImageViewBuilder(systemName: "chevron.backward")
            .setTintColor(hexColor: "#ffffff")
            .setContentMode(.center)
        let comp = ButtonImageBuilder()
            .setImageButton(img)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(24)
                    .setLeading.equalToSafeArea(16)
                    .setSize.equalToConstant(35)
            }
        return comp
    }()
    
    lazy var stepTextTitle: CustomTextTitle = {
        let comp = CustomTextTitle()
            .setText("Etapa 1 de 2")
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(backButton.get)
                    .setLeading.equalTo(backButton.get, .trailing)
                    .setTrailing.equalToSafeArea(16)
            }
        return comp
    }()
    
    lazy var tableViewIdentification: TableViewBuilder = {
        let comp = TableViewBuilder()
            .setShowsScroll(false, .both)
            .setSeparatorStyle(.none)
            .setBackgroundColor(color: .clear)
            .setRegisterCell(NameTableViewCell.self)
            .setRegisterCell(CPFTableViewCell.self)
            .setRegisterCell(DataOfBirthTableViewCell.self)
            .setRegisterCell(PhoneNumberTableViewCell.self)
            .setRegisterCell(FieldOfWorkTableViewCell.self)
            .setRegisterCell(SummaryAddressTableViewCell.self)
            .setConstraints { build in
                build
                    .setTop.equalTo(stepTextTitle.get, .bottom, 16)
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
        stepTextTitle.add(insideTo: self)
        tableViewIdentification.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        stepTextTitle.applyConstraint()
        tableViewIdentification.applyConstraint()
    }
}
