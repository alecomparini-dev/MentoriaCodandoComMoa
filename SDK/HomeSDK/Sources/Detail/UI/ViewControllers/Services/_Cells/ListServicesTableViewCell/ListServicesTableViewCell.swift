//  Created by Alessandro Comparini on 23/10/23.
//

import UIKit
import HomePresenters

class ListServicesTableViewCell: UITableViewCell {
    public static let identifier = String(describing: ListServicesTableViewCell.self)
    typealias editCompletionHandler = () -> Void
    
    private var editCompletionHander: editCompletionHandler?
    
    private var servicePresenterDTO: ServicePresenterDTO?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - CREATE SCREEN
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
        configCardServiceView()
        guard servicePresenterDTO != nil else { return showSkeleton() }
        self.editCompletionHander = editCompletionHandler
        resetSkeleton()
        
    }
    
//  MARK: - PUBLIC AREA
    
    
    

//  MARK: - PRIVATE AREA
    
    private func configure() {
        configSelectionStyle()
        configBackgroundColor()
        addElements()
        configConstraints()
        configDelegate()
    }
    
    private func configSelectionStyle() {
        self.selectionStyle = .none
    }
    
    private func configBackgroundColor() {
        backgroundColor = .clear
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
    
    public func configCardServiceView() {
        screen.cardServiceView.titleServiceLabel.setText(servicePresenterDTO?.name)
        screen.cardServiceView.subTitleServiceLabel.setText(servicePresenterDTO?.description)
        screen.cardServiceView.durationLabel.setText(servicePresenterDTO?.duration)
        screen.cardServiceView.howMutchLabel.setText(servicePresenterDTO?.howMutch)
    }
    
    private func showSkeleton() {
        screen.cardServiceView.titleServiceLabel.skeleton?.showSkeleton()
        screen.cardServiceView.subTitleServiceLabel.skeleton?.showSkeleton()
        screen.cardServiceView.durationLabel.skeleton?.showSkeleton()
        screen.cardServiceView.howMutchLabel.skeleton?.showSkeleton()
        screen.editView.skeleton?.showSkeleton()
    }
    
    private func resetSkeleton() {
        screen.cardServiceView.titleServiceLabel.skeleton?.hideSkeleton()
        screen.cardServiceView.subTitleServiceLabel.skeleton?.hideSkeleton()
        screen.cardServiceView.durationLabel.skeleton?.hideSkeleton()
        screen.cardServiceView.howMutchLabel.skeleton?.hideSkeleton()
        screen.editView.skeleton?.hideSkeleton()
    }
    
}


//  MARK: - EXTENSION - ListServicesTableViewCellViewDelegate
extension ListServicesTableViewCell: ListServicesTableViewCellViewDelegate {
    
    func editButtonTapped() {
        editCompletionHander?()
    }
    
    
}
