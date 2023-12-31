//  Created by Alessandro Comparini on 24/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent


public protocol AddServiceViewDelegate: AnyObject {
    func backButtonTapped()
    func disableButtonTapped()
}

public class SaveServiceView: UIView {
    public weak var delegate: AddServiceViewDelegate?
    
    public var constraintsBottom: NSLayoutConstraint!
    
    public init() {
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
    
    lazy var screenTitle: CustomTextTitle = {
        let comp = CustomTextTitle()
            .setText("")
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(24)
                    .setLeading.setTrailing.equalToSafeArea(16)
            }
        return comp
    }()

    lazy var backButton: ButtonImageBuilder = {
        let img = ImageViewBuilder(systemName: "chevron.backward")
            .setContentMode(.center)
        let comp = ButtonImageBuilder()
            .setImageButton(img)
            .setImageColor(hexColor: "#ffffff")
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(screenTitle.get)
                    .setLeading.equalToSafeArea(16)
                    .setSize.equalToConstant(35)
            }
        comp.get.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return comp
    }()
    @objc private func backButtonTapped() {
        delegate?.backButtonTapped()
    }
    
    lazy var disableServiceButton: ButtonImageBuilder = {
        let img = ImageViewBuilder(systemName: "trash")
            .setContentMode(.center)
            .setSize(18)
        let comp = ButtonImageBuilder()
            .setImageButton(img)
            .setImageColor(UIColor.HEX("#ffffff",0.6))
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(backButton.get,4)
                    .setTrailing.equalToSafeArea(-24)
                    .setSize.equalToConstant(25)
            }
        comp.get.addTarget(self, action: #selector(disableButtonTapped), for: .touchUpInside)
        return comp
    }()
    @objc private func disableButtonTapped() {
        delegate?.disableButtonTapped()
    }
    
    lazy var tableViewScreen: TableViewBuilder = {
        let comp = TableViewBuilder()
            .setShowsScroll(false, .both)
            .setSeparatorStyle(.none)
            .setBackgroundColor(.clear)
            .setRegisterCell(SaveServiceTableViewCell.self)
            .setConstraints { build in
                build
                    .setTop.equalTo(backButton.get, .bottom, 16)
                    .setLeading.setTrailing.equalToSafeArea
            }
        return comp
    }()
    
     

//  MARK: - PRIVATE AREA
    
    private func configure() {
        setBackgroundColor(hexColor: "#282A35")
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        backgroundView.add(insideTo: self)
        backButton.add(insideTo: self)
        disableServiceButton.add(insideTo: self)
        screenTitle.add(insideTo: self)
        tableViewScreen.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        backButton.applyConstraint()
        disableServiceButton.applyConstraint()
        screenTitle.applyConstraint()
        configTableViewScreenConstraints()
    }
    
    private func configTableViewScreenConstraints() {
        tableViewScreen.applyConstraint()
        self.constraintsBottom = NSLayoutConstraint(item: self.tableViewScreen.get,
                                                    attribute: .bottom,
                                                    relatedBy: .equal,
                                                    toItem: self.safeAreaLayoutGuide,
                                                    attribute: .bottom,
                                                    multiplier: 1,
                                                    constant: 0)
        self.constraintsBottom.isActive = true
        
    }
    
    
}
