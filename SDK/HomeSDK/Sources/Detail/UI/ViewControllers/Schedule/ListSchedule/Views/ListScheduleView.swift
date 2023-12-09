//  Created by Alessandro Comparini on 29/11/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent


protocol ListScheduleViewDelegate: AnyObject {
    func addScheduleFloatButtonTapped()
}

class ListScheduleView: UIView {
    weak var delegate: ListScheduleViewDelegate?
    
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
    
    lazy var screenTitle: CustomTextTitle = {
        let comp = CustomTextTitle()
            .setText("Dezembro")
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(24)
                    .setHorizontalAlignmentX.equalToSafeArea
            }
        return comp
    }()
    
    lazy var changeDateButton: ButtonImageBuilder = {
        let img = ImageViewBuilder(systemName: "chevron.down")
            .setSize(15)
        let comp = ButtonImageBuilder()
            .setImageButton(img)
            .setTintColor(screenTitle.get.textColor)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(screenTitle.get, 4)
                    .setLeading.equalTo(screenTitle.get, .trailing)
                    .setWidth.equalToConstant(45)
                    .setHeight.equalTo(screenTitle.get)
            }
        return comp
    }()

    lazy var menuSandwich: ImageViewBuilder = {
        let comp = ImageViewBuilder(systemName: "line.3.horizontal")
            .setContentMode(.left)
            .setTintColor(hexColor: "#FFFFFF")
            .setSize(24)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(screenTitle.get)
                    .setLeading.equalToSafeArea(16)
                    .setWidth.equalToConstant(35)
                    .setHeight.equalToConstant(40)
            }
        return comp
    }()
    
    lazy var filterDock: DockBuilder = {
        let comp = DockBuilder()
            .setContentInset(top: 0, left: 16, bottom: 0, rigth: 16)
            .setShowsHorizontalScrollIndicator(false)
            .setEnableToggleItemSelection(false)
            .setMinimumInteritemSpacing(20)
            .setConstraints { build in
                build
                    .setTop.equalTo(screenTitle.get, .bottom, 8)
                    .setLeading.setTrailing.equalToSafeArea
                    .setHeight.equalToConstant(70)
            }
        return comp
    }()
    
    lazy var backgroundListView: ViewBuilder = {
        let comp = ViewBuilder()
            .setBorder { build in
                build
                    .setCornerRadius(36)
                    .setWhichCornersWillBeRounded([.top])
            }
            .setConstraints { build in
                build
                    .setTop.equalTo(filterDock.get, .bottom, 8)
                    .setPinBottom.equalToSafeArea
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
                    .setTop.equalTo(backgroundListView.get, .top, 24)
                    .setLeading.setTrailing.equalToSafeArea(36)
                    .setHeight.equalToConstant(40)
            }
        return comp
    }()
    
    lazy var listSchedule: ListBuilder = {
        let comp = ListBuilder()
            .setRowHeight(210)
            .setSectionHeaderHeight(50)
            .setSeparatorStyle(.singleLine)
            .setPadding(top: 0, left: 0, bottom: 70, right: 0)
            .setConstraints { build in
                build
                    .setTop.equalTo(searchTextField.get, .bottom, 8)
                    .setPinBottom.equalToSafeArea
            }
        return comp
    }()
    
    lazy var addScheduleFloatButton: ButtonImageBuilder = {
        let img = ImageViewBuilder(systemName: "calendar.badge.plus")
            .setSize(16)
            .setContentMode(.left)
        let btn = ButtonImageBuilder()
            .setImageButton(img)
            .setFloatButton()
            .setBackgroundColor(hexColor: "#fa79c7")
            .setImageWeight(.black)
            .setTintColor(hexColor: "#ffffff")
            .setBorder({ build in
                build
                    .setCornerRadius(25)
            })
            .setConstraints { build in
                build
                    .setTrailing.setBottom.equalToSafeArea(16)
                    .setSize.equalToConstant(50)
            }
        btn.get.addTarget(self, action: #selector(addScheduleFloatButtonTapped), for: .touchUpInside)
        return btn
    }()
    @objc private func addScheduleFloatButtonTapped(_ button: UIButton) {
        delegate?.addScheduleFloatButtonTapped()
    }
    
    
//  MARK: - PUBLIC AREA
    func configStyleOnComponents() {
        configStyleBackgroundListView()
        configStyleAddScheduleFloatButton()
        configStyleSearchTextField()
    }
    
    
    
//  MARK: - PRIVATE AREA
    
    private func configStyleBackgroundListView() {
        backgroundListView
            .setShadow({ build in
                build
                    .setColor(.black)
                    .setRadius(10)
                    .setOpacity(0.8)
                    .setOffset(width: -2, height: -2)
                    .apply()
            })
            .setGradient({ build in
                build
                    .setReferenceColor(referenceHexColor: "#444966", percentageGradient: 20)
                    .setAxialGradient(.leftToRight)
                    .apply()
            })
    }
    
    
    private func configStyleAddScheduleFloatButton() {
        addScheduleFloatButton
            .setNeumorphism({ build in
                build
                    .setShape(.convex)
                    .setReferenceColor(hexColor: "#fa79c7")
                    .setDistance(to: .light, percent: 2)
                    .setDistance(to: .dark, percent: 10)
                    .setBlur(to: .light, percent: 3)
                    .setBlur(to: .dark, percent: 10)
                    .setIntensity(to: .light, percent: 30)
                    .setIntensity(to: .dark, percent: 100)
                    .apply()
            })
    }
    
    private func configStyleSearchTextField() {
        searchTextField.setShadow({ build in
            build
                .setColor(hexColor: "#000000")
                .setRadius(5)
                .setOffset(width: 2, height: 2)
                .apply()
        })
    }
    
    private func configure() {
        addElements()
        configConstraints()
    }
    
    
    
    private func addElements() {
        backgroundView.add(insideTo: self)
        menuSandwich.add(insideTo: self)
        screenTitle.add(insideTo: self)
        changeDateButton.add(insideTo: self)
        filterDock.add(insideTo: self)
        backgroundListView.add(insideTo: self)
        listSchedule.add(insideTo: backgroundListView.get)
        searchTextField.add(insideTo: self)
        addScheduleFloatButton.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        menuSandwich.applyConstraint()
        screenTitle.applyConstraint()
        changeDateButton.applyConstraint()
        filterDock.applyConstraint()
        backgroundListView.applyConstraint()
        listSchedule.applyConstraint()
        searchTextField.applyConstraint()
        addScheduleFloatButton.applyConstraint()
    }
    
    
}
