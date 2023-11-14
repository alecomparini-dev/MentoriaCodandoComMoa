//  Created by Alessandro Comparini on 23/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent

public class CardServiceView: ViewBuilder {
    
    public override init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - LAZY AREA
    
    lazy var cardView: ViewBuilder = {
        let comp = ViewBuilder()
            .setBackgroundColor(UIColor.HEX("#ffffff", 0.9))
            .setBorder({ build in
                build
                    .setCornerRadius(12)
                    .setWidth(1)
                    .setColor(UIColor.HEX("#fa79c7").withAlphaComponent(0.8))
            })
            .setConstraints { build in
                build
                    .setPin.equalToSafeArea
            }
        return comp
    }()
    
    lazy var titleServiceLabel: CustomTextTitle = {
        let comp = CustomTextTitle()
            .setColor(hexColor: "#34394f")
            .setWeight(.bold)
            .setSize(16)
            .setTextAlignment(.left)
            .setSkeleton({ build in
                build.setCornerRadius(4)
            })
            .setConstraints { build in
                build
                    .setTop.setLeading.setTrailing.equalToSafeArea(16)
                    .setHeight.equalToConstant(20)
                    .setWidth.greaterThanOrEqualToConstant(60)
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
            .setSkeleton({ build in
                build.setCornerRadius(4)
                    .setColorSkeleton(hexColor: "#fa79c7")
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(titleServiceLabel.get, .bottom, 6)
                    .setLeading.equalTo(titleServiceLabel.get, .leading, -8)
                    .setWidth.equalToConstant(68)
                    .setHeight.equalToConstant(2)
            }
        return comp
    }()
    
    lazy var subTitleServiceLabel: CustomText = {
        let comp = CustomText()
            .setTextAlignment(.justified)
            .setColor(UIColor.HEX("#282A35", 0.7))
            .setSize(14)
            .setNumberOfLines(3)
            .setSkeleton({ build in
                build.setCornerRadius(4)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(underlineView.get, .bottom, 6)
                    .setLeading.setTrailing.equalTo(titleServiceLabel.get)
                    .setHeight.greaterThanOrEqualToConstant(55)
            }
        return comp
    }()

    lazy var durationLabel: CustomTextSecondary = {
        let comp = CustomTextSecondary()
            .setColor(UIColor.HEX("#282A35", 0.7))
            .setSize(14)
            .setSkeleton({ build in
                build.setCornerRadius(4)
            })
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(howMutchLabel.get)
                    .setTrailing.equalTo(pointView.get, .leading, -8)
                    .setHeight.greaterThanOrEqualToConstant(20)
                    .setWidth.greaterThanOrEqualToConstant(35)
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
    
    lazy var howMutchLabel: CustomTextSecondary = {
        let comp = CustomTextSecondary()
            .setColor(UIColor.HEX("#282A35", 0.8))
            .setWeight(.bold)
            .setSize(14)
            .setSkeleton({ build in
                build.setCornerRadius(4)
            })
            .setConstraints { build in
                build
                    .setTrailing.equalTo(subTitleServiceLabel.get, .trailing, 2)
                    .setBottom.equalToSafeArea(-8)
                    .setHeight.equalToConstant(25)
                    .setWidth.greaterThanOrEqualToConstant(50)
            }
        return comp
    }()
    
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
        configShaddowCardView()
    }
        
    private func addElements() {
        cardView.add(insideTo: self.get)
        titleServiceLabel.add(insideTo: self.get)
        underlineView.add(insideTo: self.get)
        subTitleServiceLabel.add(insideTo: self.get)
        durationLabel.add(insideTo: self.get)
        pointView.add(insideTo: self.get)
        howMutchLabel.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        cardView.applyConstraint()
        titleServiceLabel.applyConstraint()
        underlineView.applyConstraint()
        subTitleServiceLabel.applyConstraint()
        durationLabel.applyConstraint()
        pointView.applyConstraint()
        howMutchLabel.applyConstraint()
    }
    
    private func configShaddowCardView() {
        cardView.get.layer.masksToBounds = false
        cardView.get.layer.shadowColor = UIColor.HEX("#565b79").cgColor
        cardView.get.layer.shadowOpacity = 1
        cardView.get.layer.shadowRadius = 3
        cardView.get.layer.shadowOffset = CGSize(width: 5, height: 5)
    }
        
}
