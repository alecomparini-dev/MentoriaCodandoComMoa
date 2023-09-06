
//  Created by Alessandro Comparini on 30/08/23.
//

import UIKit
import DSMComponent

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
    
    lazy var customButton: CustomButton = {
        let btn = CustomButton("Botão Back Login")
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(50)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(50)
            }
        btn.get.addTarget(self, action: #selector(buttomCustomizeTapped), for: .touchUpInside)
        return btn
    }()
    @objc private func buttomCustomizeTapped() {
        delegate?.buttonTapped()
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        configBackgroundColor()
        addElements()
        configConstraints()
    }
    
    private func configBackgroundColor() {
        self.backgroundColor = .orange
    }
    
    private func addElements() {
        addSubview(customButton.get)
    }
    
    private func configConstraints() {
        customButton.applyConstraint()
    }
    
    
}
