//  Created by Alessandro Comparini on 23/10/23.
//

import UIKit

class ListServicesTableViewCell: UITableViewCell {
    public static let identifier = String(describing: ListServicesTableViewCell.self)
    
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
    
    func setup() {
        
    }
    

//  MARK: - PRIVATE AREA
    
    private func configure() {
        configSelectionStyle()
        addElements()
        configConstraints()
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
    
    
}
