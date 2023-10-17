//  Created by Alessandro Comparini on 09/10/23.
//

import UIKit

public protocol ProfileSummaryViewControllerCoordinator: AnyObject {
    func gotoProfileRegistrationStep1()
}

public final class ProfileSummaryViewController: UIViewController {
    public weak var coordinator: ProfileSummaryViewControllerCoordinator?
    
    private enum TypeCells: Int {
        case profilePicture = 0
        case cpf = 1
        case dataOfBirth = 2
        case phoneNumber = 3
        case fieldOfWork = 4
        case summaryAddress = 5
        case editProfileButton = 6
    }
    
    public lazy var screen: ProfileSummaryView = {
        let view = ProfileSummaryView()
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
                return 180
                
            case .editProfileButton:
                return 260
                
            default:
                return 105
        }
        
    }
    
    private func getTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        
        switch TypeCells(rawValue: indexPath.row ) {
            
            case .cpf:
                return getCPFTableViewCell(tableView, indexPath)
        
            case .dataOfBirth:
                return getDataOfBirthTableViewCell(tableView, indexPath)
            
            case .profilePicture:
                return getProfilePictureTableViewCell(tableView, indexPath)

            case .phoneNumber:
                return getPhoneNumberTableViewCell(tableView, indexPath)
            
            case .fieldOfWork:
                return getFieldOfWorkTableViewCell(tableView, indexPath)
            
            case .summaryAddress:
                return getSummaryAddressTableViewCell(tableView, indexPath)
            
            case .editProfileButton:
                return getEditProfileButtonTableViewCell(tableView, indexPath)
                
            default:
                let cell = UITableViewCell()
                cell.backgroundColor = .clear
                return cell
        }
        
    }
    
    private func getProfilePictureTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfilePictureTableViewCell.identifier, for: indexPath) as? ProfilePictureTableViewCell
        cell?.setupCell(self)
        return cell ?? UITableViewCell()
    }
    
    private func getCPFTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CPFTableViewCell.identifier, for: indexPath) as? CPFTableViewCell
        cell?.setupCell()
        cell?.cpfTextField.setReadOnly(true)
        return cell ?? UITableViewCell()
    }
    
    private func getDataOfBirthTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DateOfBirthTableViewCell.identifier, for: indexPath) as? DateOfBirthTableViewCell
        cell?.setupCell()
        cell?.dateOfBirthTextField.setReadOnly(true)
        return cell ?? UITableViewCell()
    }
    
    private func getPhoneNumberTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhoneNumberTableViewCell.identifier, for: indexPath) as? PhoneNumberTableViewCell
        cell?.setupCell()
        cell?.phoneNumberTextField.setReadOnly(true)
        return cell ?? UITableViewCell()
    }
    
    private func getFieldOfWorkTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FieldOfWorkTableViewCell.identifier, for: indexPath) as? FieldOfWorkTableViewCell
        cell?.setupCell()
        return cell ?? UITableViewCell()
    }

    private func getSummaryAddressTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SummaryAddressTableViewCell.identifier, for: indexPath) as? SummaryAddressTableViewCell
        cell?.setupCell()
        cell?.summaryAddressTextView.setReadOnly(true)
        return cell ?? UITableViewCell()
    }
    
    private func getEditProfileButtonTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EditProfileButtonTableViewCell.identifier, for: indexPath) as? EditProfileButtonTableViewCell
        cell?.delegate = self
        return cell ?? UITableViewCell()
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
        
        let cell = getTableViewCell(tableView, indexPath)
        
        cell.selectionStyle = .none
        
        cell.backgroundColor = .clear
        
        return cell
    }
    
}

//  MARK: - EXTENSION TABLEVIEW DELEGATE
extension ProfileSummaryViewController: EditProfileButtonTableViewCellDelegate {
    
    public func editProfileTapped() {
        coordinator?.gotoProfileRegistrationStep1()
    }
    
}

