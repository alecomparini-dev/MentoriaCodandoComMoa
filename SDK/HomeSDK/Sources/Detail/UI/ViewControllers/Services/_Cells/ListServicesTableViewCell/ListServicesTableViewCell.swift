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
        guard let servicePresenterDTO else {return}
        self.servicePresenterDTO = servicePresenterDTO
        self.editCompletionHander = editCompletionHandler
        resetSkeleton()
        configCardServiceView()
        
    }
    
//  MARK: - PUBLIC AREA
    public func configSkeleton() {
        screen.cardServiceView.titleServiceLabel.setSkeleton { build in
            build.showSkeleton(.gradientAnimated)
        }
        screen.cardServiceView.subTitleServiceLabel.setSkeleton { build in
            build
                .setSkeletonLineSpacing(4)
                .showSkeleton(.gradientAnimated)
        }
        screen.cardServiceView.durationLabel.setSkeleton { build in
            build.showSkeleton(.gradientAnimated)
        }
        screen.cardServiceView.howMutchLabel.setSkeleton { build in
            build.showSkeleton(.gradientAnimated)
        }
        screen.editView.setSkeleton { build in
            build.showSkeleton(.gradientAnimated)
        }
        screen.editButton.setHidden(true)
        
    }
    
    private func resetSkeleton() {
        screen.cardServiceView.titleServiceLabel.get.hideSkeleton()
        screen.cardServiceView.subTitleServiceLabel.get.hideSkeleton()
        screen.cardServiceView.durationLabel.get.hideSkeleton()
        screen.cardServiceView.howMutchLabel.get.hideSkeleton()
        screen.editView.get.hideSkeleton(transition: .crossDissolve(0))
        screen.editButton.setHidden(false)
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
    
    public func configCardServiceView() {
        screen.cardServiceView.titleServiceLabel.setText(servicePresenterDTO?.name)
        screen.cardServiceView.subTitleServiceLabel.setText(servicePresenterDTO?.description)
        screen.cardServiceView.durationLabel.setText(servicePresenterDTO?.duration)
        screen.cardServiceView.howMutchLabel.setText(servicePresenterDTO?.howMutch)
    }
    
    
}


//  MARK: - EXTENSION - ListServicesTableViewCellViewDelegate
extension ListServicesTableViewCell: ListServicesTableViewCellViewDelegate {
    
    func editButtonTapped() {
        editCompletionHander?(servicePresenterDTO)
    }
    
    
}
