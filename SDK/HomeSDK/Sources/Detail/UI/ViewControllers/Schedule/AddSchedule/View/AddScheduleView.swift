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
            .setSize(15)
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
                    .setHeight.equalToConstant(40)
            }
        return comp
    }()
    
    lazy var serviceCustomText: CustomText = {
        let comp = CustomText()
            .setText("Serviço")
            .setSize(15)
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
                    .setHeight.equalToConstant(40)
            }
        return comp
    }()
    
    lazy var picker: PickerBuilder = {
        let comp = PickerBuilder()
            .setHidden(true)
            .setRowHeight(50)
            .setBackgroundColor(.white)
            .setBorder({ build in
                build
                    .setCornerRadius(16)
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
                    .setLeading.setTrailing.equalTo(serviceTextField.get)
                    .setHeight.equalToConstant(180)
            }
        return comp
    }()
    
    lazy var dateLabel: CustomTextTitle = {
        let comp = CustomTextTitle()
            .setSize(22)
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalTo(serviceTextField.get, .bottom, 24)
                    .setHorizontalAlignmentX.equalToSafeArea(-16)
            }
        return comp
    }()
    
    lazy var changeDateButton: ButtonImageBuilder = {
        let img = ImageViewBuilder(systemName: "chevron.down")
            .setSize(14)
        let comp = ButtonImageBuilder()
            .setImageButton(img)
            .setTintColor(screenTitle.get.textColor)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(dateLabel.get, 2)
                    .setLeading.equalTo(dateLabel.get, .trailing)
                    .setWidth.equalToConstant(40)
                    .setHeight.equalTo(dateLabel.get)
            }
        return comp
    }()
    
    lazy var daysDock: DockBuilder = {
        let comp = DockBuilder()
            .setContentInset(top: 0, left: 16, bottom: 0, rigth: 16)
            .setShowsHorizontalScrollIndicator(false)
            .setMinimumLineSpacing(20)
            .setConstraints { build in
                build
                    .setTop.equalTo(changeDateButton.get, .bottom, 8)
                    .setLeading.setTrailing.equalToSafeArea
                    .setHeight.equalToConstant(70)
            }
        return comp
    }()
    
    lazy var hoursDock: DockBuilder = {
        let comp = DockBuilder()
            .setBackgroundColor(backgroundView.get.backgroundColor?.adjustBrightness(50))
            .setScrollDirection(.vertical)
            .setContentInset(top: 24, left: 16, bottom: 24, rigth: 16)
            .setShowsVerticalScrollIndicator(false)
            .setMinimumLineSpacing(20)
            .setBorder({ build in
                build
                    .setCornerRadius(16)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(daysDock.get, .bottom, 16)
                    .setLeading.setTrailing.equalToSafeArea(8)
                    .setBottom.equalTo(saveButton.get, .top, -24)
            }
        return comp
    }()
    
    lazy var saveButton: CustomButtonPrimary = {
        let comp = CustomButtonPrimary("Agendar")
            .setConstraints { build in
                build
                    .setBottom.equalToSafeArea(-24)
                    .setLeading.setTrailing.equalToSafeArea(44)
                    .setHeight.equalToConstant(48)
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
        dateLabel.add(insideTo: self)
        changeDateButton.add(insideTo: self)
        daysDock.add(insideTo: self)
        hoursDock.add(insideTo: self)
        saveButton.add(insideTo: self)
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
        dateLabel.applyConstraint()
        changeDateButton.applyConstraint()
        daysDock.applyConstraint()
        hoursDock.applyConstraint()
        saveButton.applyConstraint()
    }
    
    private func configTopAnchorServicePicker( ) {
        pickerClientTextFieldTopAnchor = NSLayoutConstraint(item: picker.get, attribute: .top , relatedBy: .equal, toItem: clientTextField.get, attribute: .bottom, multiplier: 1, constant: 2)
        pickerServiceTextFieldTopAnchor = NSLayoutConstraint(item: picker.get, attribute: .top , relatedBy: .equal, toItem: serviceTextField.get, attribute: .bottom, multiplier: 1, constant: 2)
    }
    
}

