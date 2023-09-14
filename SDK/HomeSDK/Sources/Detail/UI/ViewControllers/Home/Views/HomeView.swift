
//  Created by Alessandro Comparini on 30/08/23.
//

import UIKit
import DSMComponent
import CustomComponentsSDK

protocol HomeViewDelegate: AnyObject {
    func buttonTapped()
}

class HomeView: UIView {
    weak var delegate: HomeViewDelegate?
    
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
            .setBackgroundColor(color: .orange)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return comp
    }()

    lazy var homeCustomTextTitle: CustomTextTitle = {
        let comp = CustomTextTitle()
            .setText("HOME")
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(24)
                    .setLeading.setTrailing.equalToSafeArea(16)
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
        homeCustomTextTitle.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        homeCustomTextTitle.applyConstraint()
    }
    
    
}
