//  Created by Alessandro Comparini on 05/12/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent

class AddScheduleDaysDockView: UIView {
    private let day: String
    private let dayWeek: String
    
    init(_ day: String, _ dayWeek: String) {
        self.day = day
        self.dayWeek = dayWeek
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - LAZY AREA
    lazy var backgroundView: CustomView = {
        let comp = CustomView()
            .setBorder({ build in
                build
                    .setCornerRadius(8)
                    .setWidth(1)
                    .setColor(hexColor: "#baa0f4")
            })
            .setConstraints { build in
                build
                    .setPinTop.equalToSafeArea
                    .setBottom.equalToSafeArea(-4)
            }
        return comp
    }()
    
    lazy var dayLabel: LabelBuilder = {
        let comp = LabelBuilder(day)
            .setSize(24)
            .setColor(.white)
            .setWeight(.semibold)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(8)
                    .setHorizontalAlignmentX.equalToSafeArea
            }
        return comp
    }()
    
    lazy var dayWeakLabel: LabelBuilder = {
        let comp = LabelBuilder(dayWeek)
            .setSize(12)
            .setColor(.white.withAlphaComponent(0.8))
            .setWeight(.regular)
            .setConstraints { build in
                build
                    .setBottom.equalToSafeArea(-10)
                    .setHorizontalAlignmentX.equalToSafeArea
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
        dayLabel.add(insideTo: self)
        dayWeakLabel.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        dayLabel.applyConstraint()
        dayWeakLabel.applyConstraint()
    }
    
}
