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
    
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.searchBarStyle = .prominent
        
        search.clipsToBounds = true
        search.barTintColor = .white
//        search.placeholder = "Pesquisar serviços"

        search.searchTextField.textColor = .black
        search.searchTextField.backgroundColor = .white
        search.searchTextField.leftView?.tintColor = .gray
        
        search.searchTextField.clearButtonMode = .whileEditing
        let clearButton = search.searchTextField.value(forKey: "_clearButton") as! UIButton
        let img = clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        clearButton.setImage(img, for: .normal)
        clearButton.tintColor = .gray.withAlphaComponent(0.6)

        let att: [NSAttributedString.Key: Any] = [.foregroundColor : UIColor.gray]
        search.searchTextField.attributedPlaceholder = NSAttributedString (
            string: "Pesquisar serviços",
            attributes: att
        )
        
        return search
    }()
    
    public lazy var tableViewListServices: TableViewBuilder = {
        let comp = TableViewBuilder()
            .setShowsScroll(false, .both)
            .setSeparatorStyle(.none)
            .setBackgroundColor(color: .clear)
            .setRegisterCell(ListServicesTableViewCell.self)
            .setConstraints { build in
                build
                    .setTop.equalTo(searchBar, .bottom, 16)
                    .setPinBottom.equalToSafeArea
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
        textTitle.add(insideTo: self)
        addSubview(searchBar)
        tableViewListServices.add(insideTo: self)
        
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        textTitle.applyConstraint()
        tableViewListServices.applyConstraint()
        configTableViewListServicesConstraints()
    }
    
    private func configTableViewListServicesConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: textTitle.get.bottomAnchor, constant: 24),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
        
}
