//  Created by Alessandro Comparini on 13/10/23.
//

import UIKit

import DesignerSystemSDKComponent
import CustomComponentsSDK


protocol ProfileRegistrationStep2ViewDelegate: AnyObject {
    func backButtonTapped()
}

class ProfileRegistrationStep2View: UIView {
    weak var delegate: ProfileRegistrationStep2ViewDelegate?
    
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
            .setText("Etapa 2 de 2")
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
            .setBackgroundColor(color: .clear)
//            .setRegisterCell(ContinueRegistrationProfileButtonTableViewCell.self)
            .setConstraints { build in
                build
                    .setTop.equalTo(backButton.get, .bottom, 36)
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
        backButton.add(insideTo: self)
        tableViewIdentification.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        backButton.applyConstraint()
        stepTextTitle.applyConstraint()
        tableViewIdentification.applyConstraint()
    }
    
}
