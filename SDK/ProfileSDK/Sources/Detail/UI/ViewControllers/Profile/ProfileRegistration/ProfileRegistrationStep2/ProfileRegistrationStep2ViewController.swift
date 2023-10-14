//  Created by Alessandro Comparini on 13/10/23.
//

import UIKit

public protocol ProfileRegistrationStep2ViewControllerCoordinator: AnyObject {
    func gotoProfileRegistrationStep1()
    func gotoProfileHomeTabBar()
}


public final class ProfileRegistrationStep2ViewController: UIViewController {

    public weak var coordinator: ProfileRegistrationStep2ViewControllerCoordinator?
    
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
    }
    
}


//  MARK: - EXTENSION TABLEVIEW DELEGATE
extension ProfileRegistrationStep2ViewController: ProfileRegistrationStep2ViewDelegate {
    
    func backButtonTapped() {
        coordinator?.gotoProfileRegistrationStep1()
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.identifier, for: indexPath) as? AddressTableViewCell
        
        cell?.setupCell()
        
        cell?.selectionStyle = .none
        
        cell?.backgroundColor = .clear
        
        return cell ?? UITableViewCell()
        
    }
    
}
