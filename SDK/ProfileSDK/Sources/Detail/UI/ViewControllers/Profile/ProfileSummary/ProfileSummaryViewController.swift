//  Created by Alessandro Comparini on 09/10/23.
//

import UIKit


public final class ProfileSummaryViewController: UIViewController {
    
    private enum TypeCells: Int {
        case profilePicture = 0
        case cpf = 1
        case dataOfBirth = 2
        case phoneNumber = 3
        case fieldOfWork = 4
        case summaryAddress = 5
        case updateProfileButton = 6
    }
    
    lazy var screen: ProfileSummaryView = {
        let view = ProfileSummaryView(viewController: self)
        return view
    }()

    
//  MARK: - LIFE CYCLE

    public override func loadView() {
        self.view = screen
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        configDelegate()
    }
    
    private func configDelegate() {
        screen.tableViewScroll.setDelegate(delegate: self)
        screen.tableViewScroll.setDataSource(dataSource: self)
    }
    
    private func calculateHeightForRowAt(_ index: Int) -> CGFloat {
        switch TypeCells(rawValue: index) {
            case .profilePicture:
                return 220
                
            case .summaryAddress:
                return 210
                
            case .updateProfileButton:
                return 180
                
            default:
                return 100
        }
        
    }
    
}


//  MARK: - EXTENSION TABLEVIEW DELEGATE
extension ProfileSummaryViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return calculateHeightForRowAt(indexPath.row)
    }
}


//  MARK: - EXTENSION TABLEVIEW DATASOURCE
extension ProfileSummaryViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
//        cell.selectionStyle = .none
        cell.backgroundColor = .red.withAlphaComponent(0.3)
        
        return cell
    }
    
    
}
