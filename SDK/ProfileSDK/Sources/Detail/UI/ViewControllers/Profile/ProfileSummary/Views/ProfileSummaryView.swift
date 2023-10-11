//  Created by Alessandro Comparini on 09/10/23.
//

import UIKit

import DesignerSystemSDKComponent
import CustomComponentsSDK

class ProfileSummaryView: UIView {
    
    private weak var viewController: UIViewController!
    
    init(viewController: UIViewController) {
        self.viewController = viewController
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
    
    
    lazy var profilePictureView: ProfilePictureBuilder = {
        let comp = ProfilePictureBuilder(size: 112)
            .setBackgroundColor(hexColor: "#FFFFFF")
            .setTintColor("#000000")
            .setChooseSource(viewController: viewController, { build in
                build
                    .setTitle("Escolha:")
                    .setOpenCamera { _ in }
                    .setOpenGallery { _ in }
            })
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(80)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(120)
                    
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
        profilePictureView.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        profilePictureView.applyConstraint()
    }
}
