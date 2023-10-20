//  Created by Alessandro Comparini on 09/10/23.
//

import UIKit

import ProfilePresenters
import CustomComponentsSDK

public protocol ProfileSummaryViewControllerCoordinator: AnyObject {
    func gotoProfileRegistrationStep1(_ profilePresenterDTO: ProfilePresenterDTO?)
}

public final class ProfileSummaryViewController: UIViewController {
    public weak var coordinator: ProfileSummaryViewControllerCoordinator?
    
    private enum TypeCells: Int {
        case profilePicture = 0
        case cpf = 1
        case dateOfBirth = 2
        case phoneNumber = 3
        case fieldOfWork = 4
        case summaryAddress = 5
        case editProfileButton = 6
    }
    
    private var profileSummaryPresenter: ProfileSummaryPresenter
    
    private var fieldsCell: [TypeCells: UITableViewCell] = [:]
    private var profilePresenterDTO: ProfilePresenterDTO?
    
    
//  MARK: - INITIALIZERS
    
    public init(profileSummaryPresenter: ProfileSummaryPresenter) {
        self.profileSummaryPresenter = profileSummaryPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        return screen.tableViewScroll.get.reloadData()
//        if let profilePresenterDTO, profilePresenterDTO.userIDAuth != nil {
//            return screen.tableViewScroll.get.reloadData()
//        }
    }
    
    private func getUserAuthenticated() {
        if let profilePresenterDTO, profilePresenterDTO.userIDAuth != nil {return}
        profileSummaryPresenter.getUserAuthenticated()
    }

//  MARK: - DATA TRANSFER
    
    public func setDataTransfer(_ data: Any?) {
        if let profilePresenterDTO = data as? ProfilePresenterDTO {
            self.profilePresenterDTO = profilePresenterDTO
        }
    }

    
//  MARK: - PRIVATE AREA
    private func configure() {
        configDelegate()
        getUserAuthenticated()
    }
    
    private func configDelegate() {
        configTableViewDelegate()
        configProfileSymmaryOutPutDelegate()
    }
     
    private func configTableViewDelegate() {
        screen.tableViewScroll.setDelegate(delegate: self)
        screen.tableViewScroll.setDataSource(dataSource: self)
    }
    
    private func configProfileSymmaryOutPutDelegate() {
        profileSummaryPresenter.outputDelegate = self
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
        
            case .dateOfBirth:
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
        cell?.configSkeleton()
        cell?.setupCell(self, profilePresenterDTO: profilePresenterDTO)
        setCell(cell, key: TypeCells.profilePicture)
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
    
    private func getCPFTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CPFTableViewCell.identifier, for: indexPath) as? CPFTableViewCell
        cell?.configSkeleton()
        cell?.setupCell(profilePresenterDTO)
        cell?.cpfTextField.setReadOnly(true)
        setCell(cell, key: TypeCells.cpf)
        return cell ?? UITableViewCell()
    }
    
    private func getDataOfBirthTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DateOfBirthTableViewCell.identifier, for: indexPath) as? DateOfBirthTableViewCell
        cell?.configSkeleton()
        cell?.setupCell(profilePresenterDTO)
        cell?.dateOfBirthTextField.setReadOnly(true)
        setCell(cell, key: TypeCells.dateOfBirth)
        return cell ?? UITableViewCell()
    }
    
    private func getPhoneNumberTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhoneNumberTableViewCell.identifier, for: indexPath) as? PhoneNumberTableViewCell
        cell?.configSkeleton()
        cell?.setupCell(profilePresenterDTO)
        cell?.phoneNumberTextField.setReadOnly(true)
        setCell(cell, key: TypeCells.phoneNumber)
        return cell ?? UITableViewCell()
    }
    
    private func getFieldOfWorkTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FieldOfWorkTableViewCell.identifier, for: indexPath) as? FieldOfWorkTableViewCell
        cell?.configSkeleton()
        cell?.setupCell(profilePresenterDTO)
        cell?.fieldOfWorkTextField.setReadOnly(true)
        setCell(cell, key: TypeCells.fieldOfWork)
        return cell ?? UITableViewCell()
    }

    private func getSummaryAddressTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SummaryAddressTableViewCell.identifier, for: indexPath) as? SummaryAddressTableViewCell
        cell?.configSkeleton()
        cell?.setupCell(profilePresenterDTO)
        cell?.summaryAddressTextView.setReadOnly(true)
        setCell(cell, key: TypeCells.summaryAddress)
        return cell ?? UITableViewCell()
    }
    
    private func getEditProfileButtonTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EditProfileButtonTableViewCell.identifier, for: indexPath) as? EditProfileButtonTableViewCell
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
    
    private func setCell(_ cell: UITableViewCell?, key: TypeCells) {
        if let cell {
            fieldsCell.updateValue(cell, forKey: key)
        }
    }

}


//  MARK: - EXTENSION - UITableViewDelegate
extension ProfileSummaryViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return calculateHeightForRowAt(indexPath.row)
    }
}


//  MARK: - EXTENSION - UITableViewDataSource
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

//  MARK: - EXTENSION - EditProfileButtonTableViewCellDelegate
extension ProfileSummaryViewController: EditProfileButtonTableViewCellDelegate {
    
    public func editProfileTapped() {
        coordinator?.gotoProfileRegistrationStep1(profilePresenterDTO)
    }
    
}


//  MARK: - EXTENSION - ProfileSummaryPresenterOutput
extension ProfileSummaryViewController: ProfileSummaryPresenterOutput {
    
    public func getUserAuthenticated(success: ProfilePresenterDTO?, error: String?) {
        screen.tableViewScroll.get.reloadData()
        print(success ?? "")
        if let userIDAuth = success?.userIDAuth {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                self.profileSummaryPresenter.getProfile(userIDAuth)
            })
            
        }
    }
    
    public func getUserProfile(success: ProfilePresenterDTO?, error: String?) {
        profilePresenterDTO = success
        screen.tableViewScroll.get.reloadData()
    }
    
}



//  MARK: - EXTENSION - ProfilePictureTableViewCellDelegate
extension ProfileSummaryViewController: ProfilePictureTableViewCellDelegate {
    func saveProfileImage(_ image: UIImage) {
        print(image)
    }
    
}

