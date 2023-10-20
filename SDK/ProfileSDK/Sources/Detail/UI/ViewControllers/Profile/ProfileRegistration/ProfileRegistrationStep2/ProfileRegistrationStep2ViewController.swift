//  Created by Alessandro Comparini on 13/10/23.
//

import UIKit

import DesignerSystemSDKComponent
import ProfilePresenters

public protocol ProfileRegistrationStep2ViewControllerCoordinator: AnyObject {
    func gotoProfileRegistrationStep1(_ profilePresenterDTO: ProfilePresenterDTO?)
    func gotoProfileHomeTabBar()
}


public final class ProfileRegistrationStep2ViewController: UIViewController {
    public weak var coordinator: ProfileRegistrationStep2ViewControllerCoordinator?
    private weak var addressCell: AddressTableViewCell?
    
    private var profilePresenterDTO: ProfilePresenterDTO = ProfilePresenterDTO()
    private var profileStep2Presenter: ProfileRegistrationStep2Presenter
    private var constantBottom: CGFloat?
    
    
//  MARK: - INITIALIZERS
    
    public init(profileStep2Presenter: ProfileRegistrationStep2Presenter) {
        self.profileStep2Presenter = profileStep2Presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var screen: ProfileRegistrationStep2View = {
        let view = ProfileRegistrationStep2View()
        return view
    }()
    
    deinit {
        unregisterKeyboardNotifications()
    }
    
    
//  MARK: - DATA TRANSFER
    public func setDataTransfer(_ data: Any?) {
        if let profile = data as? ProfilePresenterDTO {
            self.profilePresenterDTO = profile
        }
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
        screen.tableViewAddress.setDelegate(delegate: self)
        screen.tableViewAddress.setDataSource(dataSource: self)
        screen.delegate = self
        profileStep2Presenter.outputDelegate = self
    }
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        if constantBottom == nil {
            self.constantBottom = (screen.tableViewAddress.get.bounds.height - keyboardFrame.origin.y) + 75
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
    
    private func resetFields() {
        addressCell?.streetTextField.setText("")
        addressCell?.neighborhoodTextField.setText("")
        addressCell?.cityTextField.setText("")
        addressCell?.stateTextField.setText("")
    }
    
    private func setHiddenFieldRequired(_ requiredLabel: FieldRequiredCustomTextSecondary?, _ flag: Bool) {
        if let requiredLabel {
            requiredLabel.setHidden(flag)
        }
    }
    
    private func setFieldsRequired(fields: [ProfileRegistrationStep2PresenterImpl.FieldsRequired]) {
        fields.forEach { field in
            switch field {
            case .cep:
                setHiddenFieldRequired(addressCell?.CEPFieldRequired, false)
            case .number:
                setHiddenFieldRequired(addressCell?.numberFieldRequired, false)
            case .street:
                break
            }
        }
    }
    
    private func updateProfilePresenterDTO() {
        profilePresenterDTO.address?.cep = addressCell?.searchCEPTextField.get.text
        profilePresenterDTO.address?.street = addressCell?.streetTextField.get.text
        profilePresenterDTO.address?.number = addressCell?.numberTextField.get.text
        profilePresenterDTO.address?.neighborhood = addressCell?.neighborhoodTextField.get.text
        profilePresenterDTO.address?.city = addressCell?.cityTextField.get.text
        profilePresenterDTO.address?.state = addressCell?.stateTextField.get.text
    }
    
}


//  MARK: - EXTENSION - ProfileRegistrationStep2ViewDelegate
extension ProfileRegistrationStep2ViewController: ProfileRegistrationStep2ViewDelegate {
    
    func backButtonTapped() {
        updateProfilePresenterDTO()
        coordinator?.gotoProfileRegistrationStep1(profilePresenterDTO)
    }
    
}


//  MARK: - EXTENSION - ProfileRegistrationStep2PresenterOutput
extension ProfileRegistrationStep2ViewController: ProfileRegistrationStep2PresenterOutput {
    
    public func searchCEP(success: CEPDTO?, error: String?) {
        if let cepDTO = success {
            addressCell?.streetTextField.get.text = cepDTO.street
            addressCell?.neighborhoodTextField.get.text = cepDTO.neighborhood
            addressCell?.cityTextField.get.text = cepDTO.city
            addressCell?.stateTextField.get.text = cepDTO.stateShortname
        }
        
        if let error {
            let alert = UIAlertController(title: "Aviso", message: error , preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
            resetFields()
        }
        
        addressCell?.loading.setStopAnimating()
    }
    
    public func validations(validationsError: String?, fieldsRequired: [ProfileRegistrationStep2PresenterImpl.FieldsRequired]) {
        if let validationsError {
            let alert = UIAlertController(title: "Aviso", message: validationsError, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        }
        
        if !fieldsRequired.isEmpty {
            setFieldsRequired(fields: fieldsRequired)
            if fieldsRequired.contains(where: { $0 == .cep}) {
                screen.tableViewAddress.get.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }

    
}


//  MARK: - EXTENSION TABLEVIEW DELEGATE
extension ProfileRegistrationStep2ViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 840
    }
}


//  MARK: - EXTENSION TABLEVIEW DATASOURCE
extension ProfileRegistrationStep2ViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        addressCell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.identifier, for: indexPath) as? AddressTableViewCell
        
        addressCell?.delegate = self
        
        addressCell?.selectionStyle = .none
        
        addressCell?.backgroundColor = .clear
        
        addressCell?.setupCell(profilePresenterDTO)
        
        return addressCell ?? UITableViewCell()
        
    }
    
}


//  MARK: - EXTENSION - AddressTableViewCellDelegate
extension ProfileRegistrationStep2ViewController: AddressTableViewCellDelegate {

    func confirmationTapped() {
        updateProfilePresenterDTO()
        profileStep2Presenter.createProfile(profilePresenterDTO)
    }
    
    func searchCEPTapped(_ textField: UITextField?, _ cep: String) {
        textField?.resignFirstResponder()
        profileStep2Presenter.searchCep(cep)
        addressCell?.loading.setStartAnimating()
    }

    func textFieldShouldChangeCharactersIn(_ fieldRequired: AddressTableViewCell.FieldRequired, range: NSRange, string: String) {
        switch fieldRequired {
            case .searchCEP:
                setHiddenFieldRequired(addressCell?.CEPFieldRequired, true)
                addressCell?.searchCEPTextField.get.text = profileStep2Presenter.setCEPMaskWithRange(range, string)
                resetFields()
            
            case .number:
                setHiddenFieldRequired(addressCell?.numberFieldRequired, true)
        }
        
    }

    
}
