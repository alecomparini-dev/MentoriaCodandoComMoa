//  Created by Alessandro Comparini on 23/10/23.
//

import UIKit
import HomePresenters

class ListServicesTableViewCell: UITableViewCell {
    public static let identifier = String(describing: ListServicesTableViewCell.self)
    typealias editCompletionHandler = (_ servicePresenterDTO: ServicePresenterDTO?) -> Void
    
    private var editCompletionHander: editCompletionHandler?
    
    private var servicePresenterDTO: ServicePresenterDTO?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - CREATE ELEMENT SCREEN
    public lazy var screen: ListServicesTableViewCellView = {
        let view = ListServicesTableViewCellView()
            .setConstraints { build in
                build
                    .setPin.equalToSafeArea
            }
        return view
    }()

    
//  MARK: - SETUP CELL
    
    public func setupCell(_ servicePresenterDTO: ServicePresenterDTO?, _ editCompletionHandler: @escaping editCompletionHandler) {
        self.servicePresenterDTO = servicePresenterDTO
        self.editCompletionHander = editCompletionHandler
    }
    

//  MARK: - PRIVATE AREA
    
    private func configure() {
        configSelectionStyle()
        addElements()
        configConstraints()
        configDelegate()
    }
    
    private func configSelectionStyle() {
        self.selectionStyle = .none
    }
    
    private func addElements() {
        screen.add(insideTo: self.contentView)
    }
    
    private func configConstraints() {
        screen.applyConstraint()
    }
    
    private func configDelegate() {
        screen.delegate = self
    }
    
}


//  MARK: - EXTENSION - ListServicesTableViewCellViewDelegate
extension ListServicesTableViewCell: ListServicesTableViewCellViewDelegate {
    
    func editButtonTapped() {
        editCompletionHander?(servicePresenterDTO)
    }
    
    
}
