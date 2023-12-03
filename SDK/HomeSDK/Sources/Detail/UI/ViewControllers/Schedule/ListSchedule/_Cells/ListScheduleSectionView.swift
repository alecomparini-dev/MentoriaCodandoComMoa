//  Created by Alessandro Comparini on 02/12/23.
//


import UIKit
import CustomComponentsSDK
import HomePresenters

class ListScheduleSectionView: UIView {
    private let schedulePresenterDTO: SchedulePresenterDTO
    
    init(schedulePresenterDTO: SchedulePresenterDTO) {
        self.schedulePresenterDTO = schedulePresenterDTO
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var backgroundView: ViewBuilder = {
        let comp = ViewBuilder()
            .setGradient({ build in
                build
                    .setReferenceColor(referenceHexColor: "#444966", percentageGradient: 20)
                    .setAxialGradient(.leftToRight)
                    .apply()
            })
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return comp
    }()
    
    lazy var triangleImage: ImageViewBuilder = {
        let comp = ImageViewBuilder(systemName: "arrowtriangle.right.fill")
            .setTintColor(hexColor: "#fa79c7")
            .setContentMode(.scaleAspectFill)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSafeArea
                    .setLeading.equalToSafeArea(32)
                    .setSize.equalToConstant(25)
            }
        return comp
    }()
    
    lazy var triangleShadowImage: ImageViewBuilder = {
        let comp = ImageViewBuilder(systemName: "arrowtriangle.right.fill")
            .setAlpha(0.3)
            .setTintColor(.black.withAlphaComponent(0.8))
            .setContentMode(.scaleAspectFill)
            .setConstraints { build in
                build
                    .setTop.equalTo(triangleImage.get, .top)
                    .setLeading.equalTo(triangleImage.get, .leading, 2)
                    .setSize.equalToConstant(30)
            }
        return comp
    }()
    
    lazy var dateScheduleLabel: LabelBuilder = {
        let comp = LabelBuilder()
            .setSize(22)
            .setColor(.white)
            .setWeight(.bold)
            .setTextAttributed({ build in
                build
                    .setText(text: "16 /")
                    .setAttributed(key: .font, value: UIFont.boldSystemFont(ofSize: 24))
                    .setText(text: " Nov")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 20))
                    .setText(text: "  terça-feira")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 16))
                    .setAttributed(key: .foregroundColor, value: UIColor.white.withAlphaComponent(0.7))
            })
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(triangleImage.get)
                    .setLeading.equalTo(triangleImage.get, .trailing, 12)
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
        triangleShadowImage.add(insideTo: self)
        triangleImage.add(insideTo: self)
        dateScheduleLabel.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        triangleImage.applyConstraint()
        triangleShadowImage.applyConstraint()
        dateScheduleLabel.applyConstraint()
    }
    
    
}



