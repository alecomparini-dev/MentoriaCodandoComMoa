//  Created by Alessandro Comparini on 25/10/23.
//

import UIKit

import HomePresenters

public class SaveServiceTableViewCell: UITableViewCell {
    public static let identifier = String(describing: SaveServiceTableViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - CREATE SCREEN
    public lazy var screen: SaveServiceViewCell = {
        let view = SaveServiceViewCell()
            .setConstraints { build in
                build
                    .setPin.equalToSafeArea
            }
        return view
    }()
    
    
    //  MARK: - SETUP CELL
    public func setupCell(_ servicePresenterDTO: ServicePresenterDTO? ) {
        guard let servicePresenterDTO else {return}
        screen.titleServiceTextField.setText(servicePresenterDTO.name)
        screen.descriptionServiceTextView.setInsertText(servicePresenterDTO.description)
        screen.durationServiceTextField.setText(servicePresenterDTO.duration)
        screen.howMutchServiceTextField.setText(servicePresenterDTO.howMutch)
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
