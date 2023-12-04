//  Created by Alessandro Comparini on 01/12/23.
//


import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent


public protocol AddScheduleViewDelegate: AnyObject {
    func backButtonTapped()
    func disableScheduleButtonTapped()
}


public class AddScheduleView: UIView {
    public weak var delegate: AddScheduleViewDelegate?
    
    public var pickerClientTextFieldTopAnchor: NSLayoutConstraint!
    public var pickerServiceTextFieldTopAnchor: NSLayoutConstraint!
    
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

    lazy var disableScheduleButton: ButtonImageBuilder = {
        let img = ImageViewBuilder(systemName: "trash")
            .setContentMode(.center)
            .setSize(15)
        let comp = ButtonImageBuilder()
            .setImageButton(img)
            .setImageColor(UIColor.HEX("#ffffff",0.6))
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(backButton.get,4)
                    .setTrailing.equalToSafeArea(-24)
                    .setSize.equalToConstant(25)
            }
        comp.get.addTarget(self, action: #selector(disableScheduleButtonTapped), for: .touchUpInside)
        return comp
    }()
    @objc private func disableScheduleButtonTapped() {
        delegate?.disableScheduleButtonTapped()
    }
    
    lazy var clientTitle: CustomText = {
        let comp = CustomText()
            .setText("Cliente")
            .setConstraints { build in
                build
                    .setTop.equalTo(screenTitle.get, .bottom, 40)
                    .setLeading.setTrailing.equalToSafeArea(24)
            }
        return comp
    }()
    
    lazy var clientTextField: TextFieldImageBuilder = {
        let personImg = ImageViewBuilder(systemName: "magnifyingglass")
        let comp = TextFieldImageBuilder("Pesquisar cliente")
            .setTag(AddScheduleViewController.TagTextField.client.rawValue)
            .setImage(personImg, .right, 8)
            .setAutoCapitalization(.none)
            .setBackgroundColor(hexColor: "#ffffff")
            .setPadding(8)
            .setKeyboard({ build in
                build
                    .setKeyboardType(.default)
                    .setClearButton() { [weak self] textfield in
                        self?.picker.setHidden(true)
                    }
            })
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(clientTitle.get, .bottom, 8)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(48)
            }
        return comp
    }()
    
    lazy var serviceCustomText: CustomText = {
        let comp = CustomText()
            .setText("Serviço")
            .setConstraints { build in
                build
                    .setTop.equalTo(clientTextField.get, .bottom, 16)
                    .setLeading.equalTo(clientTitle.get, .leading)
            }
        return comp
    }()
    
    lazy var serviceTextField: TextFieldImageBuilder = {
        let personImg = ImageViewBuilder(systemName: "magnifyingglass")
        let comp = TextFieldImageBuilder("Pesquisar serviço")
            .setTag(AddScheduleViewController.TagTextField.service.rawValue)
            .setImage(personImg, .right, 8)
            .setAutoCapitalization(.none)
            .setBackgroundColor(hexColor: "#ffffff")
            .setPadding(8)
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setKeyboard({ build in
                build
                    .setKeyboardType(.default)
                    .setClearButton() { [weak self] textfield in
                        self?.picker.setHidden(true)
                    }
                    .setReturnKeyType(.default) { textField in
                        textField.get.resignFirstResponder()
                    }
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(serviceCustomText.get, .bottom, 8)
                    .setLeading.setTrailing.equalTo(clientTextField.get)
                    .setHeight.equalToConstant(48)
            }
        return comp
    }()
    
    lazy var picker: PickerBuilder = {
        let comp = PickerBuilder()
            .setHidden(true)
            .setRowHeight(50)
            .setBackgroundColor(.white.withAlphaComponent(0.9))
            .setBorder({ build in
                build
                    .setCornerRadius(16)
//                    .setWhichCornersWillBeRounded([.bottom])
                    .setWidth(1)
                    .setColor(hexColor: "#baa0f4")
            })
            .setShadow({ build in
                build
                    .setColor(.black)
                    .setRadius(8)
                    .setOpacity(1)
                    .setOffset(width: 3, height: 4)
                    .apply()
            })
            .setConstraints { build in
                build
//                    .setTop.equalTo(serviceTextField.get, .bottom, 2)
                    .setLeading.setTrailing.equalTo(serviceTextField.get)
                    .setHeight.equalToConstant(180)
            }
        return comp
    }()
    
//  MARK: - PUBLIC AREA
    func setTopAnchorClient() {
        picker.setHidden(false)
        pickerServiceTextFieldTopAnchor.isActive = false
        pickerClientTextFieldTopAnchor.isActive = true
    }
    
    func setTopAnchorService() {
        picker.setHidden(false)
        pickerClientTextFieldTopAnchor.isActive = false
        pickerServiceTextFieldTopAnchor.isActive = true
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        addElements()
        configConstraints()
        configTopAnchorServicePicker()
    }
    
    private func addElements() {
        backgroundView.add(insideTo: self)
        screenTitle.add(insideTo: self)
        backButton.add(insideTo: self)
        disableScheduleButton.add(insideTo: self)
        clientTitle.add(insideTo: self)
        clientTextField.add(insideTo: self)
        serviceCustomText.add(insideTo: self)
        serviceTextField.add(insideTo: self)
        picker.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        screenTitle.applyConstraint()
        backButton.applyConstraint()
        disableScheduleButton.applyConstraint()
        clientTitle.applyConstraint()
        clientTextField.applyConstraint()
        serviceCustomText.applyConstraint()
        serviceTextField.applyConstraint()
        picker.applyConstraint()
    }
    
    private func configTopAnchorServicePicker( ) {
        pickerClientTextFieldTopAnchor = NSLayoutConstraint(item: picker.get, attribute: .top , relatedBy: .equal, toItem: clientTextField.get, attribute: .bottom, multiplier: 1, constant: 2)
        pickerServiceTextFieldTopAnchor = NSLayoutConstraint(item: picker.get, attribute: .top , relatedBy: .equal, toItem: serviceTextField.get, attribute: .bottom, multiplier: 1, constant: 2)
    }
    
}

