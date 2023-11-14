//  Created by Alessandro Comparini on 25/10/23.
//

import UIKit

import DesignerSystemSDKComponent
import CustomComponentsSDK


public protocol ViewerServiceViewDelegate: AnyObject {
    func disableButtomTapped()
    func backButtonTapped()
    func editButtonTapped()
}


public class ViewerServiceView: UIView {
    public weak var delegate: ViewerServiceViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - LAZY AREA
    lazy var backgroundView: ViewBuilder = {
        let comp = ViewBuilder()
            .setBackgroundColor(hexColor: "#363a51")
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return comp
    }()

    lazy var grabberView: ViewBuilder = {
        let comp = ViewBuilder()
            .setBackgroundColor(hexColor: "#282a36")
            .setBorder({ build in
                build
                    .setCornerRadius(2)
            })
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(10)
                    .setWidth.equalToConstant(45)
                    .setHeight.equalToConstant(4)
                    .setHorizontalAlignmentX.equalToSuperView
            }
        return comp
    }()
    
    lazy var disableServiceButton: ButtonImageBuilder = {
        let img = ImageViewBuilder(systemName: "trash")
            .setContentMode(.center)
        let comp = ButtonImageBuilder()
            .setImageButton(img)
            .setImageColor(UIColor.HEX("#ffffff",0.6))
            .setConstraints { build in
                build
                    .setTop.setLeading.equalToSafeArea(24)
                    .setSize.equalToConstant(30)
            }
        comp.get.addTarget(self, action: #selector(disableButtomTapped), for: .touchUpInside)
        return comp
    }()
    @objc private func disableButtomTapped() {
        delegate?.disableButtomTapped()
    }
    
    lazy var backButton: ButtonImageBuilder = {
        let img = ImageViewBuilder(systemName: "chevron.down")
            .setContentMode(.center)
        let comp = ButtonImageBuilder()
            .setImageButton(img)
            .setImageColor(hexColor: "#FFFFFF")
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(disableServiceButton.get)
                    .setTrailing.equalToSafeArea(-24)
                    .setSize.equalToConstant(35)
            }
        comp.get.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return comp
    }()
    @objc private func backButtonTapped() {
        delegate?.backButtonTapped()
    }
    
    lazy var titleServiceLabel: CustomTextTitle = {
        let comp = CustomTextTitle()
            .setText("Dev iOS")
            .setSize(22)
            .setTextAlignment(.center)
            .setNumberOfLines(2)
            .setConstraints { build in
                build
                    .setTop.equalTo(disableServiceButton.get, .bottom, 16)
                    .setLeading.equalTo(disableServiceButton.get, .leading, 8 )
                    .setTrailing.equalTo(backButton.get, .trailing, -8)
            }
        return comp
    }()
    
    lazy var underlineView: ViewBuilder = {
        let comp = ViewBuilder()
            .setBackgroundColor(hexColor: "#fa79c7")
            .setBorder({ build in
                build
                    .setCornerRadius(12)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(titleServiceLabel.get, .bottom, 4)
                    .setHorizontalAlignmentX.equalTo(titleServiceLabel.get)
                    .setWidth.equalToConstant(80)
                    .setHeight.equalToConstant(2)
            }
        return comp
    }()
    
    lazy var subTitleServiceLabel: TextViewBuilder = {
        let comp = TextViewBuilder()
            .setTextAlignment(.justified)
            .setReadOnly(true)
            .setPadding(left: 16, top: 16, right: 16, bottom: 16)
            .setLineSpacing(10)
            .setSize(17)
            .setBorder({ build in
                build
                    .setCornerRadius(12)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(titleServiceLabel.get, .top, 68)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(160)
            }
        return comp
    }()

    lazy var durationLabel: CustomTextSecondary = {
        let comp = CustomTextSecondary()
            .setColor(UIColor.HEX("#ffffff", 0.7))
            .setSize(16)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(howMutchLabel.get)
                    .setTrailing.equalTo(pointView.get, .leading, -8)
            }
        return comp
    }()
    
    lazy var pointView: ViewBuilder = {
        let comp = ViewBuilder()
            .setBackgroundColor(hexColor: "#B281EB")
            .setBorder({ build in
                build.setCornerRadius(3)
            })
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(howMutchLabel.get)
                    .setTrailing.equalTo(howMutchLabel.get, .leading, -8)
                    .setSize.equalToConstant(6)
            }
        return comp
    }()
    
    lazy var howMutchLabel: CustomText = {
        let comp = CustomText()
            .setText("R$ 50,00")
            .setColor(UIColor.HEX("#ffffff", 0.8))
            .setWeight(.bold)
            .setSize(18)
            .setConstraints { build in
                build
                    .setTop.equalTo(subTitleServiceLabel.get, .bottom, 16)
                    .setTrailing.equalTo(subTitleServiceLabel.get, .trailing, -16)
            }
        return comp
    }()
    
    
    lazy var editButtom: CustomButtonSecondary = {
        let comp = CustomButtonSecondary("Editar")
            .setHidden(true)
            .setConstraints { build in
                build
                    .setTop.equalTo(howMutchLabel.get, .bottom, 72)
                    .setLeading.setTrailing.equalToSafeArea(44)
                    .setHeight.equalToConstant(48)
            }
        comp.get.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        return comp
    }()
    @objc private func editButtonTapped() {
        delegate?.editButtonTapped()
    }
    
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
    }
        
    private func addElements() {
        backgroundView.add(insideTo: self)
        grabberView.add(insideTo: self)
        disableServiceButton.add(insideTo: self)
        backButton.add(insideTo: self)
        titleServiceLabel.add(insideTo: self)
        underlineView.add(insideTo: self)
        subTitleServiceLabel.add(insideTo: self)
        durationLabel.add(insideTo: self)
        pointView.add(insideTo: self)
        howMutchLabel.add(insideTo: self)
        editButtom.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        grabberView.applyConstraint()
        disableServiceButton.applyConstraint()
        backButton.applyConstraint()
        titleServiceLabel.applyConstraint()
        underlineView.applyConstraint()
        subTitleServiceLabel.applyConstraint()
        durationLabel.applyConstraint()
        pointView.applyConstraint()
        howMutchLabel.applyConstraint()
        editButtom.applyConstraint()
    }
    
        
}
