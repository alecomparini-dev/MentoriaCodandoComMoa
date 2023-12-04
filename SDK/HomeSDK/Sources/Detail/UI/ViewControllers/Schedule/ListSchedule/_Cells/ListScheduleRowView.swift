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
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(8)
                    .setLeading.equalToSuperView(20)
                    .setTrailing.equalToSuperView(-24)
                    .setBottom.equalToSuperView(-24)
            }
        return comp
    }()
    
    
    lazy var clientName: LabelBuilder = {
        let comp = LabelBuilder("ALESSANDRO COMPARINI")
            .setSize(16)
            .setColor(UIColor.white)
            .setWeight(.light)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(8)
                    .setLeading.equalToSafeArea(18)
                    .setTrailing.equalToSafeArea(-60)
                    .setHeight.equalToConstant(40)
            }
        return comp
    }()
    
    
    lazy var hourView: ViewBuilder = {
        let comp = ViewBuilder()
            .setConstraints { build in
                build
                    .setTop.equalTo(clientName.get, .bottom, -18)
                    .setLeading.setBottom.equalTo(backgroundView.get)
                    .setWidth.equalToConstant(70)
            }
        return comp
    }()
    
    lazy var hourLabel: LabelBuilder = {
        let comp = LabelBuilder()
            .setTextAlignment(.center)
            .setNumberOfLines(2)
            .setTextAttributed({ build in
                build
                    .setText(text: "18")
                    .setAttributed(key: .font, value: UIFont.boldSystemFont(ofSize: 28))
                    .setAttributed(key: .foregroundColor, value: UIColor.white)
                    .setText(text: "\n25")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 20))
                    .setAttributed(key: .foregroundColor, value: UIColor.white.withAlphaComponent(0.7))
            })
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return comp
    }()
    
    lazy var lineDivisor: ViewBuilder = {
        let comp = ViewBuilder()
            .setNeumorphism({ build in
                build
                    .setShape(.convex)
                    .setReferenceColor(hexColor: "#b89ef2")
                    .setDistance(to: .light, percent: 1)
                    .setDistance(to: .dark, percent: 5)
                    .setBlur(to: .light, percent: 1)
                    .setBlur(to: .dark, percent: 5)
                    .setIntensity(to: .light, percent: 30)
                    .setIntensity(to: .dark, percent: 100)
                    .apply()
            })
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(hourView.get)
                    .setTrailing.equalTo(hourView.get, .trailing, -2)
                    .setHeight.equalToConstant(80)
                    .setWidth.equalToConstant(2)
            }
        return comp
    }()
    
    
    lazy var addressTitle: LabelBuilder = {
        let comp = LabelBuilder("Endereço:")
            .setColor(UIColor.white.withAlphaComponent(0.8))
            .setSize(15)
            .setWeight(.light)
            .setConstraints { build in
                build
                    .setTop.equalTo(lineDivisor.get, .top, -2)
                    .setLeading.equalTo(lineDivisor.get, .trailing, 12)
            }
        return comp
    }()
    
    lazy var addressLabel: LabelBuilder = {
        let comp = LabelBuilder("Rua Marcos de Freitas Costas, 1222 - Apto 10")
            .setNumberOfLines(2)
            .setColor(UIColor.white)
            .setSize(14)
            .setWeight(.bold)
            .setConstraints { build in
                build
                    .setTop.equalTo(addressTitle.get, .bottom , 4)
                    .setLeading.equalTo(addressTitle.get, .leading)
                    .setTrailing.equalTo(backgroundView.get, .trailing, -8)
            }
        return comp
    }()
    
//  MARK: - PUBLIC AREA
    func setStyleOnComponents() {
        configBackgroundViewNeumorphism()
    }
    
    private func configBackgroundViewNeumorphism() {
        backgroundView
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
    }
    
//  MARK: - PRIVATE AREA

    private func configure() {
        addElements()
        configConstraints()
        
        configBackgroundViewNeumorphism()
    }
    
    private func addElements() {
        backgroundView.add(insideTo: self)
        clientName.add(insideTo: backgroundView.get)
        hourView.add(insideTo: self)
        hourLabel.add(insideTo: hourView.get)
        lineDivisor.add(insideTo: hourView.get)
        addressTitle.add(insideTo: self)
        addressLabel.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        clientName.applyConstraint()
        hourView.applyConstraint()
        hourLabel.applyConstraint()
        lineDivisor.applyConstraint()
        addressTitle.applyConstraint()
        addressLabel.applyConstraint()
    }
    
    
    
}
