//  Created by Alessandro Comparini on 23/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent

public protocol ListServicesViewDelegate: AnyObject {
    func searchTextFieldEditing(_ textField: UITextField)
    func addServiceButtonTapped()
}

public class ListServicesView: UIView {
    public weak var delegate: ListServicesViewDelegate?
    
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
            .setText("Serviços")
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(24)
                    .setLeading.setTrailing.equalToSafeArea(16)
            }
        return comp
    }()
    
    lazy var addServiceButton: ButtonImageBuilder = {
        let img = ImageViewBuilder(systemName: "plus.circle")
            .setSize(32)
        let btn = ButtonImageBuilder()
            .setImageButton(img)
            .setImageWeight(.bold)
            .setTintColor(hexColor: "#fa79c7")
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(screenTitle.get)
                    .setTrailing.equalToSafeArea(-20)
                    .setSize.equalToConstant(40)
            }
        btn.get.addTarget(self, action: #selector(addServiceButtonTapped), for: .touchUpInside)
        return btn
    }()
    @objc private func addServiceButtonTapped(_ button: UIButton) {
        delegate?.addServiceButtonTapped()
    }

    lazy var addServiceLabel: CustomText = {
        let view = CustomText()
            .setText("Adicionar")
            .setWeight(.medium)
            .setSize(10)
            .setConstraints { build in
                build
                    .setTop.equalTo(addServiceButton.get, .bottom, 2)
                    .setHorizontalAlignmentX.equalTo(addServiceButton.get)
            }
        return view
    }()
    
    lazy var searchTextField: TextFieldImageBuilder = {
        let imgSearch = ImageViewBuilder(systemName: "magnifyingglass")
        let imgMic = ImageViewBuilder(systemName: "mic.fill")
        let comp = TextFieldImageBuilder("Pesquisar")
            .setImage(imgSearch, .left, 8)
            .setImage(imgMic, .right, 8)
            .setAutoCapitalization(.none)
            .setBackgroundColor(hexColor: "#ffffff")
            .setPadding(8)
            .setKeyboard({ build in
                build
                    .setReturnKeyType(.done)
            })
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(screenTitle.get, .bottom, 32)
                    .setLeading.setTrailing.equalToSafeArea(16)
                    .setHeight.equalToConstant(48)
            }
        comp.get.addTarget(self, action: #selector(searchTextFieldEditing), for: .editingChanged)
        return comp
    }()
    @objc private func searchTextFieldEditing(_ textfield: UITextField) {
        delegate?.searchTextFieldEditing(textfield)
    }
    
    public lazy var tableViewListServices: TableViewBuilder = {
        let comp = TableViewBuilder()
            .setShowsScroll(false, .both)
            .setSeparatorStyle(.none)
            .setBackgroundColor(.clear)
            .setTableFooterView(ViewBuilder(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 50))))
            .setRegisterCell(ListServicesTableViewCell.self)
            .setConstraints { build in
                build
                    .setTop.equalTo(searchTextField.get, .bottom, 24)
                    .setPinBottom.equalToSafeArea
            }
        return comp
    }()
    
    lazy var addServiceCustomText: CustomTextSecondary = {
        let view = CustomTextSecondary()
            .setHidden(true)
            .setSize(18)
            .setTextAlignment(.center)
            .setNumberOfLines(2)
            .setText("Clique no botão adicionar, para incluir seu primeiro serviço!")
            .setConstraints { build in
                build
                    .setLeading.setTrailing.equalToSafeArea(32)
                    .setVerticalAlignmentY.equalToSuperView(30)
                    .setHorizontalAlignmentX.equalToSafeArea
            }
        return view
    }()
    

    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        setBackgroundColor(hexColor: "#282A35")
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        backgroundView.add(insideTo: self)
        screenTitle.add(insideTo: self)
        addServiceButton.add(insideTo: self)
        addServiceLabel.add(insideTo: self)
        searchTextField.add(insideTo: self)
        tableViewListServices.add(insideTo: self)
        addServiceCustomText.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        screenTitle.applyConstraint()
        addServiceButton.applyConstraint()
        addServiceLabel.applyConstraint()
        searchTextField.applyConstraint()
        tableViewListServices.applyConstraint()
        addServiceCustomText.applyConstraint()
    }
    
        
}
