//  Created by Alessandro Comparini on 23/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent

public class ListServicesView: UIView {
    
    
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
    
    lazy var textTitle: CustomTextTitle = {
        let comp = CustomTextTitle()
            .setText("Seus Serviços")
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
        let imgMic = ImageViewBuilder(systemName: "mic.fill")
        let comp = TextFieldImageBuilder("Pesquisar")
            .setImage(imgSearch, .left, 8)
            .setImage(imgMic, .right, 8)
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
                    .setTop.equalTo(textTitle.get, .bottom, 24)
                    .setLeading.setTrailing.equalToSafeArea(16)
                    .setHeight.equalToConstant(48)
            }
        return comp
    }()
    
    public lazy var tableViewListServices: TableViewBuilder = {
        let comp = TableViewBuilder()
            .setShowsScroll(false, .both)
            .setSeparatorStyle(.none)
            .setBackgroundColor(color: .clear)
            .setRegisterCell(ListServicesTableViewCell.self)
            .setConstraints { build in
                build
                    .setTop.equalTo(searchTextField.get, .bottom, 16)
                    .setPinBottom.equalToSafeArea
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
        textTitle.add(insideTo: self)
        searchTextField.add(insideTo: self)
        tableViewListServices.add(insideTo: self)
        
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        textTitle.applyConstraint()
        searchTextField.applyConstraint()
        tableViewListServices.applyConstraint()
    }
    
        
}
