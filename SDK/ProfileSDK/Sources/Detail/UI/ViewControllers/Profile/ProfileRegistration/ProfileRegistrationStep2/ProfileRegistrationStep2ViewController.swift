//  Created by Alessandro Comparini on 13/10/23.
//

import UIKit

import CustomComponentsSDK
import ProfilePresenters

public protocol ProfileRegistrationStep2ViewControllerCoordinator: AnyObject {
    func gotoProfileRegistrationStep1()
    func gotoProfileHomeTabBar()
}


public final class ProfileRegistrationStep2ViewController: UIViewController {

    public weak var coordinator: ProfileRegistrationStep2ViewControllerCoordinator?
    
    private weak var addressCell: AddressTableViewCell?
    
    private var profileStep2Presenter: ProfileRegistrationStep2Presenter
    
    
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
        screen.tableViewAddress.setDelegate(delegate: self)
        screen.tableViewAddress.setDataSource(dataSource: self)
        screen.delegate = self
        profileStep2Presenter.outputDelegate = self
    }
    
}


//  MARK: - EXTENSION - ProfileRegistrationStep2ViewDelegate
extension ProfileRegistrationStep2ViewController: ProfileRegistrationStep2ViewDelegate {
    
    func backButtonTapped() {
        coordinator?.gotoProfileRegistrationStep1()
    }
    
}


//  MARK: - EXTENSION - ProfileRegistrationStep2PresenterOutput
extension ProfileRegistrationStep2ViewController: ProfileRegistrationStep2PresenterOutput {
    
    public func error(_ error: String) {
        print(error)
    }
    
    public func searchCEPSuccess(_ cepDTO: CEPDTO) {
        addressCell?.streetTextField.get.text = cepDTO.street
        addressCell?.neighborhoodTextField.get.text = cepDTO.neighborhood
        addressCell?.cityTextField.get.text = cepDTO.city
        addressCell?.stateTextField.get.text = cepDTO.stateShortname
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
        
        return addressCell ?? UITableViewCell()
        
    }
    
}


//  MARK: - EXTENSION - AddressTableViewCellDelegate
extension ProfileRegistrationStep2ViewController: AddressTableViewCellDelegate {
    func confirmationTapped() {
        
    }
    
    func searchCEPTapped(_ textField: TextFieldBuilder?, _ cep: String) {
        textField?.get.resignFirstResponder()
        profileStep2Presenter.searchCep(cep)
    }

    
}
