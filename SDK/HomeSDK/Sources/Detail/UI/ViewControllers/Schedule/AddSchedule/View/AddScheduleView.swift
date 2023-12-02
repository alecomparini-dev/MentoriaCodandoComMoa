//  Created by Alessandro Comparini on 01/12/23.
//


import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent


public protocol AddScheduleViewDelegate: AnyObject {
    func backButtonTapped()
    func disableScheduleButtonTapped()
}


public class AddScheduleView: UIView {
    public weak var delegate: AddScheduleViewDelegate?
    
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
    
    lazy var screenTitle: CustomTextTitle = {
        let comp = CustomTextTitle()
            .setText("")
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(24)
                    .setLeading.setTrailing.equalToSafeArea(16)
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
                    .setVerticalAlignmentY.equalTo(screenTitle.get)
                    .setLeading.equalToSafeArea(16)
                    .setSize.equalToConstant(35)
            }
        comp.get.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return comp
    }()
    @objc private func backButtonTapped() {
        delegate?.backButtonTapped()
    }

    lazy var disableScheduleButton: ButtonImageBuilder = {
        let img = ImageViewBuilder(systemName: "trash")
            .setContentMode(.center)
            .setSize(15)
        let comp = ButtonImageBuilder()
            .setImageButton(img)
            .setImageColor(UIColor.HEX("#ffffff",0.6))
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(backButton.get,4)
                    .setTrailing.equalToSafeArea(-24)
                    .setSize.equalToConstant(25)
            }
        comp.get.addTarget(self, action: #selector(disableScheduleButtonTapped), for: .touchUpInside)
        return comp
    }()
    @objc private func disableScheduleButtonTapped() {
        delegate?.disableScheduleButtonTapped()
    }
    
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        backgroundView.add(insideTo: self)
        screenTitle.add(insideTo: self)
        backButton.add(insideTo: self)
        disableScheduleButton.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        screenTitle.applyConstraint()
        backButton.applyConstraint()
        disableScheduleButton.applyConstraint()
    }
    
    
}
