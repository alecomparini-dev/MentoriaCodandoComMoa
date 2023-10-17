//  Created by Alessandro Comparini on 13/10/23.
//

import UIKit

import ProfilePresenters

public protocol ProfileRegistrationStep1ViewControllerCoordinator: AnyObject {
    func gotoProfileHomeTabBar()
    func gotoProfileRegistrationStep2()
}

public final class ProfileRegistrationStep1ViewController: UIViewController {
    public weak var coordinator: ProfileRegistrationStep1ViewControllerCoordinator?
    
    private enum TypeCells: Int {
        case name = 0
        case cpf = 1
        case dataOfBirth = 2
        case phoneNumber = 3
        case fieldOfWork = 4
        case continueRegistrationButton = 5
    }
    
    private var fieldsCell: [String: UITableViewCell] = [:]
    
    private var constantBottom: CGFloat?
    private var profileStep1Presenter: ProfileRegistrationStep1Presenter

    
//  MARK: - INITIALIZERS
    public init(profileStep1Presenter: ProfileRegistrationStep1Presenter) {
        self.profileStep1Presenter = profileStep1Presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var screen: ProfileRegistrationStep1View = {
        let view = ProfileRegistrationStep1View()
        return view
    }()
    
    deinit {
        unregisterKeyboardNotifications()
    }
    
    
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
        registerKeyboardNotifications()
    }
    
    private func configDelegate() {
        screen.tableViewIdentification.setDelegate(delegate: self)
        screen.tableViewIdentification.setDataSource(dataSource: self)
        screen.delegate = self
        profileStep1Presenter.outputDelegate = self
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
        if let cell {
            fieldsCell.updateValue(cell, forKey: "CPFCell")
        }
        return cell ?? UITableViewCell()
    }
    
    private func getDataOfBirthTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DateOfBirthTableViewCell.identifier, for: indexPath) as? DateOfBirthTableViewCell
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
        cell?.delegate = self
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
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        if constantBottom == nil {
            self.constantBottom = (screen.tableViewIdentification.get.bounds.height - keyboardFrame.origin.y) + 75
        }
        repositionTableViewShowKeyboardAnimation()
        
    }
    
    private func repositionTableViewShowKeyboardAnimation() {
        UIView.animate(withDuration: 0.3, delay: 0 , options: .curveEaseInOut, animations: { [weak self] in
            guard let self else {return}
            if let constantBottom {
                screen.constraintsBottom.constant = -constantBottom
            }
        })
    }
    
    @objc private func keyboardWillHide() {
        screen.constraintsBottom.constant = 0
    }

    private func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
}


//  MARK: - EXTENSION TABLEVIEW DELEGATE
extension ProfileRegistrationStep1ViewController: ProfileRegistrationStep1ViewDelegate {
    
    func backButtonTapped() {
        coordinator?.gotoProfileHomeTabBar()
    }
    
}


//  MARK: - EXTENSION TABLEVIEW DELEGATE
extension ProfileRegistrationStep1ViewController: ContinueRegistrationProfileButtonTableViewCellDelegate {

    func continueRegistrationTapped() {
        let cpf = fieldsCell["CPFCell"] as! CPFTableViewCell
        profileStep1Presenter.continueRegistrationStep2(
            ProfileRegistrationStep1DTO(cpf: cpf.cpfTextField.get.text ?? "")
        )
//        coordinator?.gotoProfileRegistrationStep2()
    }
    
}


//  MARK: - EXTENSION TABLEVIEW DELEGATE
extension ProfileRegistrationStep1ViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return calculateHeightForRowAt(indexPath.row)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        }
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


//  MARK: - EXTENSION - ProfileRegistrationStep1PresenterOutput
extension ProfileRegistrationStep1ViewController: ProfileRegistrationStep1PresenterOutput {
    public func error(_ error: String) {
        print(error)
    }
    
    public func success(_ cepDTO: ProfilePresenters.CEPDTO) {
        print("SUCESSOOOO")
    }
    
    
}
