//  Created by Alessandro Comparini on 29/11/23.
//

import UIKit

import DesignerSystemSDKComponent
import CustomComponentsSDK


class ScheduleView: UIView {
    
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
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return comp
    }()
    
    lazy var menuSandwich: ImageViewBuilder = {
        let comp = ImageViewBuilder(systemName: "line.3.horizontal")
            .setContentMode(.scaleToFill)
            .setTintColor(hexColor: "#FFFFFF")
            .setSize(24)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(24)
                    .setLeading.equalToSafeArea(16)
                    .setWidth.equalToConstant(35)
                    .setHeight.equalToConstant(40)
            }
        return comp
    }()

    lazy var screenTitle: CustomTextTitle = {
        let comp = CustomTextTitle()
            .setText("Agenda")
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(24)
                    .setLeading.setTrailing.equalToSafeArea(16)
            }
        return comp
    }()

    
    lazy var searchTextField: TextFieldImageBuilder = {
        let imgSearch = ImageViewBuilder(systemName: "magnifyingglass")
        let comp = TextFieldImageBuilder("Pesquisar")
            .setImage(imgSearch, .left, 8)
            .setAutoCapitalization(.none)
            .setBackgroundColor(hexColor: "#ffffff")
            .setPadding(8)
            .setKeyboard({ build in
                build
                    .setKeyboardType(.emailAddress)
                    .setReturnKeyType(.continue)
            })
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(menuSandwich.get, .bottom, 40)
                    .setLeading.setTrailing.equalToSafeArea(16)
                    .setHeight.equalToConstant(48)
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
        menuSandwich.add(insideTo: self)
        screenTitle.add(insideTo: self)
        searchTextField.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        menuSandwich.applyConstraint()
        screenTitle.applyConstraint()
        searchTextField.applyConstraint()
    }
    
    
}
