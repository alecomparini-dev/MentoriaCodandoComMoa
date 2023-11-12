//  Created by Alessandro Comparini on 09/10/23.
//

import UIKit

import ProfilePresenters
import CustomComponentsSDK

public protocol ProfileSummaryViewControllerCoordinator: AnyObject {
    func gotoSignIn()
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

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
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
        setScrollToTop()
        reload()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    

//  MARK: - DATA TRANSFER
    public func setDataTransfer(_ data: Any?) {
//        if let profilePresenterDTO = data as? ProfilePresenterDTO {
//            self.profilePresenterDTO = profilePresenterDTO
//        }
    }

    
//  MARK: - PRIVATE AREA
    
    private func reload() {
        profileSummaryPresenter.clearProfilePresenter()
        reloadTableView()
        fetchUserProfile()
    }
    
    public func reloadTableView() {
        
        self.screen.tableViewScroll.get.reloadData()
    }
    
    private func fetchUserProfile() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            self?.profileSummaryPresenter.fetchUserProfile()
        })
    }
    
    private func configure() {
        configDelegate()
    }
    
    private func configDelegate() {
        configViewDelegate()
        configTableViewDelegate()
        configProfileSymmaryOutPutDelegate()
    }
    
    private func configViewDelegate() {
        screen.delegate = self
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
                return 190
                
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
                return UITableViewCell()
        }
        
    }
    
    private func configScreenToNewProfile() {
        reloadTableView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.screen.tableViewScroll.get.selectRow(at: IndexPath(row: 6, section: 0), animated: true, scrollPosition: .top)
        })
    }
    
    private func setScrollToTop() {
        self.screen.tableViewScroll.get.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
    }
    

//  MARK: - GET AND SETUP CELL
    
    private func getProfilePictureTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfilePictureTableViewCell.identifier, for: indexPath) as? ProfilePictureTableViewCell
        let profilePresenterDTO = profileSummaryPresenter.getProfilePresenter()
        let profileImageData = profileSummaryPresenter.getProfileImageData(profilePresenterDTO)
        cell?.setupCell(self, profilePresenterDTO: profilePresenterDTO, profileImage: profileImageData)
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
    
    private func getCPFTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CPFTableViewCell.identifier, for: indexPath) as? CPFTableViewCell
        cell?.setupCell(profileSummaryPresenter.getProfilePresenter())
        cell?.cpfTextField.setReadOnly(true)
        return cell ?? UITableViewCell()
    }
    
    private func getDataOfBirthTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DateOfBirthTableViewCell.identifier, for: indexPath) as? DateOfBirthTableViewCell
        cell?.setupCell(profileSummaryPresenter.getProfilePresenter())
        cell?.dateOfBirthTextField.setReadOnly(true)
        return cell ?? UITableViewCell()
    }
    
    private func getPhoneNumberTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhoneNumberTableViewCell.identifier, for: indexPath) as? PhoneNumberTableViewCell
        cell?.setupCell(profileSummaryPresenter.getProfilePresenter())
        cell?.phoneNumberTextField.setReadOnly(true)
        return cell ?? UITableViewCell()
    }
    
    private func getFieldOfWorkTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FieldOfWorkTableViewCell.identifier, for: indexPath) as? FieldOfWorkTableViewCell
        cell?.setupCell(profileSummaryPresenter.getProfilePresenter())
        cell?.fieldOfWorkTextField.setReadOnly(true)
        return cell ?? UITableViewCell()
    }

    private func getSummaryAddressTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SummaryAddressTableViewCell.identifier, for: indexPath) as? SummaryAddressTableViewCell
        cell?.setupCell(profileSummaryPresenter.getProfilePresenter())
        cell?.summaryAddressTextView.setReadOnly(true)
        return cell ?? UITableViewCell()
    }
    
    private func getEditProfileButtonTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EditProfileButtonTableViewCell.identifier, for: indexPath) as? EditProfileButtonTableViewCell
        cell?.delegate = self
        cell?.setupCell(profileSummaryPresenter.getProfilePresenter())
        return cell ?? UITableViewCell()
    }
    
    
    
//  MARK: - RESIZE PROFILE IMAGE
    private func convertImageToJPEG(_ image: UIImage) -> Data? {
        return image.jpegData(compressionQuality: 0.6)
    }
    
    private func resizeImage(_ image: UIImage) -> UIImage? {
        return image.resizeImage(targetSize: CGSize(width: 200, height: 200))
    }
}



//  MARK: - EXTENSION - ProfileSummaryViewDelegate
extension ProfileSummaryViewController: ProfileSummaryViewDelegate{
    
    public func logoutButtonTapped() {
        profileSummaryPresenter.logout()
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
        coordinator?.gotoProfileRegistrationStep1(profileSummaryPresenter.getProfilePresenter())
    }
    
}


//  MARK: - EXTENSION - ProfileSummaryPresenterOutput
extension ProfileSummaryViewController: ProfileSummaryPresenterOutput {
    
    public func successFetchUserProfile() {
        if profileSummaryPresenter.getProfilePresenter()?.userIDProfile != nil {
            reloadTableView()
            return
        }
        configScreenToNewProfile()
    }
    
    public func errorFetchUserProfile(title: String, message: String) {
        
    }

    public func successSaveProfileImage(_ profilePresenterDTO: ProfilePresenters.ProfilePresenterDTO?) {

    }
    
    public func errorSaveProfileImage(title: String, message: String) {
        
    }
    
    public func successLogout() {
        coordinator?.gotoSignIn()
    }
    
    public func errorLogout() {
        coordinator?.gotoSignIn()
    }
        
}


//  MARK: - EXTENSION - ProfilePictureTableViewCellDelegate
extension ProfileSummaryViewController: ProfilePictureTableViewCellDelegate {
    
    func saveProfileImage(_ image: UIImage) {
        var imageResize = resizeImage(image)
        if imageResize == nil { imageResize = image }

        if let imageJPEGData = convertImageToJPEG(imageResize!) {
            var profilePresenterDTO = profileSummaryPresenter.getProfilePresenter()
            profilePresenterDTO?.imageProfile = imageJPEGData.base64EncodedString()
            profileSummaryPresenter.saveProfileImageData(profilePresenterDTO)
        }
    }
}
