//  Created by Alessandro Comparini on 02/12/23.
//

import UIKit
import CustomComponentsSDK
import HomePresenters

class ListScheduleRowView: UIView {
    
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
            .setBorder({ build in
                build
                    .setCornerRadius(16)
            })
            .setNeumorphism({ build in
                build
                    .setShape(.concave)
                    .setReferenceColor(hexColor: "#4d5274")
                    .setDistance(to: .light, percent: 5)
                    .setDistance(to: .dark, percent: 10)
                    .setBlur(to: .light, percent: 5)
                    .setBlur(to: .dark, percent: 10)
                    .setIntensity(to: .light, percent: 30)
                    .setIntensity(to: .dark, percent: 100)
                    .apply()
            })
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(8)
                    .setLeading.equalToSuperView(32)
                    .setTrailing.equalToSuperView(-36)
                    .setBottom.equalToSuperView(-24)
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
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
    }
    
    
    
}
