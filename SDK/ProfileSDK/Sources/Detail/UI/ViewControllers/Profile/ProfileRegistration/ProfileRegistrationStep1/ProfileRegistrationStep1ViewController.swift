//  Created by Alessandro Comparini on 13/10/23.
//

import UIKit

import ProfilePresenters


public protocol ProfileRegistrationStep1ViewControllerCoordinator: AnyObject {
    func gotoProfileHomeTabBar()
    func gotoProfileRegistrationStep2(_ profilePresenterDTO: ProfilePresenterDTO?)
}

public final class ProfileRegistrationStep1ViewController: UIViewController {
    public weak var coordinator: ProfileRegistrationStep1ViewControllerCoordinator?
    
    private enum TypeCells: Int {
        case name = 0
        case cpf = 1
        case dateOfBirth = 2
        case phoneNumber = 3
        case fieldOfWork = 4
        case continueRegistrationButton = 5
    }
        
    private var profilePresenterDTO: ProfilePresenterDTO?
    private var fieldsCell: [TypeCells: UITableViewCell] = [:]
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
        constantBottom = nil
        fieldsCell = [:]
    }
    
    
//  MARK: - LIFE CYCLE
    public override func loadView() {
        self.view = screen
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    
//  MARK: - DATA TRANSFER
    public func setDataTransfer(_ data: Any?) {
        if let profile = data as? ProfilePresenterDTO {
            self.profilePresenterDTO = profile
        }
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
        
            case .dateOfBirth:
                return getDateOfBirthTableViewCell(tableView, indexPath)
            
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
        cell?.delegate = self
        cell?.setupCell(profilePresenterDTO)
        setCell(cell, key: TypeCells.name)
        return cell ?? UITableViewCell()
    }

    private func getCPFTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CPFTableViewCell.identifier, for: indexPath) as? CPFTableViewCell
        cell?.delegate = self
        cell?.setupCell(profilePresenterDTO)
        setCell(cell, key: TypeCells.cpf)
        return cell ?? UITableViewCell()
    }
    
    private func getDateOfBirthTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DateOfBirthTableViewCell.identifier, for: indexPath) as? DateOfBirthTableViewCell
        cell?.delegate = self
        cell?.setupCell(profilePresenterDTO)
        setCell(cell, key: TypeCells.dateOfBirth)
        return cell ?? UITableViewCell()
    }
    
    private func getPhoneNumberTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhoneNumberTableViewCell.identifier, for: indexPath) as? PhoneNumberTableViewCell
        cell?.delegate = self
        cell?.setupCell(profilePresenterDTO)
        setCell(cell, key: TypeCells.phoneNumber)
        return cell ?? UITableViewCell()
    }
    
    private func getFieldOfWorkTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FieldOfWorkTableViewCell.identifier, for: indexPath) as? FieldOfWorkTableViewCell
        cell?.delegate = self
        cell?.setupCell(profilePresenterDTO)
        setCell(cell, key: TypeCells.fieldOfWork)
        return cell ?? UITableViewCell()
    }
    
    private func getContinueRegistrationProfileButtonTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContinueRegistrationProfileButtonTableViewCell.identifier, for: indexPath) as? ContinueRegistrationProfileButtonTableViewCell
        cell?.setupCell()
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
    
    private func setCell(_ cell: UITableViewCell?, key: TypeCells) {
        if let cell {
            fieldsCell.updateValue(cell, forKey: key)
        }
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
       
    private func setHiddenFieldRequiredName(_ flag: Bool) {
        if let cell = fieldsCell[.name] as? NameTableViewCell, cell.fieldRequired.get.isHidden != flag {
            cell.fieldRequired.setHidden(flag)
        }
    }    
    
    private func setHiddenFieldRequiredCPF(_ flag: Bool) {
        if let cell = fieldsCell[.cpf] as? CPFTableViewCell, cell.fieldRequired.get.isHidden != flag {
            cell.fieldRequired.setHidden(flag)
        }
    }
    
    private func setHiddenFieldRequiredDateOfBirth(_ flag: Bool) {
        if let cell = fieldsCell[.dateOfBirth] as? DateOfBirthTableViewCell, cell.fieldRequired.get.isHidden != flag {
            cell.fieldRequired.setHidden(flag)
        }
    }

    private func setHiddenFieldRequiredCellPhone(_ flag: Bool) {
        if let cell = fieldsCell[.phoneNumber] as? PhoneNumberTableViewCell, cell.fieldRequired.get.isHidden != flag {
            cell.fieldRequired.setHidden(flag)
        }
    }
    
    private func setHiddenFieldRequiredFieldOfWork(_ flag: Bool) {
        if let cell = fieldsCell[.fieldOfWork] as? FieldOfWorkTableViewCell, cell.fieldRequired.get.isHidden != flag {
            cell.fieldRequired.setHidden(flag)
        }
    }
    
    private func setScrollToRow(_ index: Int) {
        screen.tableViewIdentification.get.scrollToRow(at: IndexPath(row: index, section: 0), at: .middle, animated: true)
    }
    
    private func setFieldsRequired(fields: [ProfileRegistrationStep1PresenterImpl.FieldsRequired]) {
        fields.forEach { field in
            switch field {
            case .name:
                setHiddenFieldRequiredName(false)
                
            case .CPF:
                setHiddenFieldRequiredCPF(false)
                
            case .dateOfBirth:
                setHiddenFieldRequiredDateOfBirth(false)
                
            case .cellPhoneNumber:
                setHiddenFieldRequiredCellPhone(false)
                
            case .fieldOfWork:
                setHiddenFieldRequiredFieldOfWork(false)
            }
        }
    }


}



//  MARK: - EXTENSION - ProfileRegistrationStep1ViewDelegate
extension ProfileRegistrationStep1ViewController: ProfileRegistrationStep1ViewDelegate {
    
    func backButtonTapped() {
        coordinator?.gotoProfileHomeTabBar()
    }
    
}


//  MARK: - EXTENSION TABLEVIEW DELEGATE
extension ProfileRegistrationStep1ViewController: ContinueRegistrationProfileButtonTableViewCellDelegate {

    func continueRegistrationTapped() {
        let name = fieldsCell[.name] as! NameTableViewCell
        let cpf = fieldsCell[.cpf] as! CPFTableViewCell
        let dateOfBirth = fieldsCell[.dateOfBirth] as! DateOfBirthTableViewCell
        let phoneNumber = fieldsCell[.phoneNumber] as! PhoneNumberTableViewCell
        let fieldOfWork = fieldsCell[.fieldOfWork] as! FieldOfWorkTableViewCell
        
        profilePresenterDTO?.name = name.nameTextField.get.text
        profilePresenterDTO?.cpf = cpf.cpfTextField.get.text
        profilePresenterDTO?.dateOfBirth = dateOfBirth.dateOfBirthTextField.get.text
        profilePresenterDTO?.cellPhoneNumber = phoneNumber.phoneNumberTextField.get.text
        profilePresenterDTO?.fieldOfWork = fieldOfWork.fieldOfWorkTextField.get.text
        
        profileStep1Presenter.continueRegistrationStep2(profilePresenterDTO)
    }
    
}


//  MARK: - EXTENSION - NameTableViewCellDelegate
extension ProfileRegistrationStep1ViewController: NameTableViewCellDelegate {
    
    func nameTextFieldShouldChangeCharactersIn() {
        setHiddenFieldRequiredName(true)
    }
}


//  MARK: - EXTENSION - NameTableViewCellDelegate
extension ProfileRegistrationStep1ViewController: CPFTableViewCellDelegate {
    
    func cpfTextFieldShouldChangeCharactersIn(_ textField: UITextField, range: NSRange, string: String) {
        setHiddenFieldRequiredCPF(true)
        textField.text = profileStep1Presenter.setMaskWithRange(.CPFMask, range, string)
        setScrollToRow(1)
    }
        
}


//  MARK: - EXTENSION - NameTableViewCellDelegate
extension ProfileRegistrationStep1ViewController: DateOfBirthTableViewCellDelegate {
    
    func dateOfBirthTextFieldShouldBeginEditing() {
        setScrollToRow(2)
    }
    
    func dateOfBirthTextFieldShouldChangeCharactersIn(_ textField: UITextField, range: NSRange, string: String) {
        setHiddenFieldRequiredDateOfBirth(true)
        textField.text = profileStep1Presenter.setMaskWithRange(.dateMask, range, string)
    }
    
}


//  MARK: - EXTENSION - NameTableViewCellDelegate
extension ProfileRegistrationStep1ViewController: PhoneNumberTableViewDelegate {
    
    func cellPhoneTextFieldShouldBeginEditing() {
        setScrollToRow(3)
    }
    
    func cellPhoneTextFieldShouldChangeCharactersIn(_ textField: UITextField, range: NSRange, string: String) {
        setHiddenFieldRequiredCellPhone(true)
        textField.text = profileStep1Presenter.setMaskWithRange(.cellPhoneMask, range, string)
        setScrollToRow(3)
    }
            
}


//  MARK: - EXTENSION - NameTableViewCellDelegate
extension ProfileRegistrationStep1ViewController: FieldOfWorkTableViewCellDelegate {
    
    func fieldOfWorkTextFieldShouldBeginEditing() {
        setScrollToRow(4)
    }
    
    func fieldOfWorkTextFieldShouldChangeCharactersIn() {
        setHiddenFieldRequiredFieldOfWork(true)
        setScrollToRow(4)
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
    
    public func validations(validationsError: String?, fieldsRequired: [ProfileRegistrationStep1PresenterImpl.FieldsRequired]) {
        if let validationsError {
            let alert = UIAlertController(title: "Aviso", message: validationsError, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        }
        
        if !fieldsRequired.isEmpty {
            setFieldsRequired(fields: fieldsRequired)
        }
    }
    
    public func error(_ error: String) {
        print(error)
    }
    
    public func success() {
        coordinator?.gotoProfileRegistrationStep2(profilePresenterDTO)
    }
    
    
}
