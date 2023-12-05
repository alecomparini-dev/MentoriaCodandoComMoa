//  Created by Alessandro Comparini on 05/12/23.
//

import Foundation

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent

class AddScheduleHoursDockView: UIView {
    
    private let hours: String
    
    init(_ hours: String) {
        self.hours = hours
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
                    .setWidth(0.5)
                    .setColor(hexColor: "#baa0f4")
            })
            .setConstraints { build in
                build
                    .setPin.equalToSafeArea
            }
        return comp
    }()
    
    lazy var hourLabel: LabelBuilder = {
        let comp = LabelBuilder(hours)
            .setSize(14)
            .setColor(.white)
            .setWeight(.light)
            .setConstraints { build in
                build
                    .setAlignmentCenterXY.equalToSafeArea
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
        hourLabel.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        hourLabel.applyConstraint()
    }
    
}
