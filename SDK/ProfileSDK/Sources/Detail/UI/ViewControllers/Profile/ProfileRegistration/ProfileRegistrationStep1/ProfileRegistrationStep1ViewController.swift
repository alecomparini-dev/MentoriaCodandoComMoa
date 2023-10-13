//  Created by Alessandro Comparini on 13/10/23.
//

import UIKit

public final class ProfileRegistrationStep1ViewController: UIViewController {
    
    private enum TypeCells: Int {
        case name = 0
        case cpf = 1
        case dataOfBirth = 2
        case phoneNumber = 3
        case fieldOfWork = 4
        case continueRegistrationButton = 5
    }
    
    lazy var screen: ProfileRegistrationStep1View = {
        let view = ProfileRegistrationStep1View()
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
        screen.tableViewIdentification.setDelegate(delegate: self)
        screen.tableViewIdentification.setDataSource(dataSource: self)
    }
    
    private func getTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        
        switch TypeCells(rawValue: indexPath.row ) {
            
            case.name:
                return getNameTableViewCell(tableView, indexPath)
                
            case .cpf:
                return getCPFTableViewCell(tableView, indexPath)
        
            case .dataOfBirth:
                return getDataOfBirthTableViewCell(tableView, indexPath)
            
            case .phoneNumber:
                return getPhoneNumberTableViewCell(tableView, indexPath)
            
            case .fieldOfWork:
                return getFieldOfWorkTableViewCell(tableView, indexPath)
            
            case .continueRegistrationButton:
                return getContinueRegistrationProfileButtonTableViewCell(tableView, indexPath)
                
            default:
                let cell = UITableViewCell()
                cell.backgroundColor = .clear
                return cell
        }
        
    }
    
    private func getNameTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NameTableViewCell.identifier, for: indexPath) as? NameTableViewCell
        cell?.setupCell()
        return cell ?? UITableViewCell()
    }

    private func getCPFTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CPFTableViewCell.identifier, for: indexPath) as? CPFTableViewCell
        cell?.setupCell()
        return cell ?? UITableViewCell()
    }
    
    private func getDataOfBirthTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DataOfBirthTableViewCell.identifier, for: indexPath) as? DataOfBirthTableViewCell
        cell?.setupCell()
        return cell ?? UITableViewCell()
    }
    
    private func getPhoneNumberTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhoneNumberTableViewCell.identifier, for: indexPath) as? PhoneNumberTableViewCell
        cell?.setupCell()
        return cell ?? UITableViewCell()
    }
    
    private func getFieldOfWorkTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FieldOfWorkTableViewCell.identifier, for: indexPath) as? FieldOfWorkTableViewCell
        cell?.setupCell()
        return cell ?? UITableViewCell()
    }
    
    private func getContinueRegistrationProfileButtonTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContinueRegistrationProfileButtonTableViewCell.identifier, for: indexPath) as? ContinueRegistrationProfileButtonTableViewCell
        cell?.setupCell()
        return cell ?? UITableViewCell()
    }
    
    private func calculateHeightForRowAt(_ index: Int) -> CGFloat {
        switch TypeCells(rawValue: index) {
                
            case .continueRegistrationButton:
                return 200
                
            default:
                return 105
        }
        
    }
    
}



//  MARK: - EXTENSION TABLEVIEW DELEGATE
extension ProfileRegistrationStep1ViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return calculateHeightForRowAt(indexPath.row)
    }
}


//  MARK: - EXTENSION TABLEVIEW DATASOURCE
extension ProfileRegistrationStep1ViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = getTableViewCell(tableView, indexPath)
        
        cell.selectionStyle = .none
        
        cell.backgroundColor = .clear
        
        return cell
    }
    
    
}

