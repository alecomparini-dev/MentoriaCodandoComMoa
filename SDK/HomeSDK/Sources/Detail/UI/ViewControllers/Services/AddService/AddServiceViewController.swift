//  Created by Alessandro Comparini on 24/10/23.
//

import UIKit

import HomePresenters

public protocol AddServiceViewControllerCoordinator: AnyObject {
    func gotoListServiceHomeTabBar()
}

public class AddServiceViewController: UIViewController {
    public weak var coordinator: AddServiceViewControllerCoordinator?
    
    private var servicePresenterDTO: ServicePresenterDTO? = ServicePresenterDTO()
    private var cellScreen: AddServiceTableViewCell?
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public lazy var screen: AddServiceView = {
        let view = AddServiceView()
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

//  MARK: - DATA TRANSFER
    public func setDataTransfer(_ data: Any?) {
        if let service = data as? ServicePresenterDTO {
            self.servicePresenterDTO = service
        }
    }
    
//  MARK: - PRIVATE AREA
    private func configure() {
        configDelegate()
    }
    
    private func configDelegate() {
        screen.delegate = self
        screen.tableViewScreen.setDelegate(delegate: self)
        screen.tableViewScreen.setDataSource(dataSource: self)
    }
    
    
}

//  MARK: - EXTENSION - AddServiceViewDelegate
extension AddServiceViewController: AddServiceViewDelegate {
    
    public func backButtonTapped() {
        coordinator?.gotoListServiceHomeTabBar()
    }
    
}


//  MARK: - EXTENSION - TABLEVIEW - UITableViewDelegate
extension AddServiceViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 640
    }
}


//  MARK: - EXTENSION - UITableViewDataSource
extension AddServiceViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        cellScreen = tableView.dequeueReusableCell(withIdentifier: AddServiceTableViewCell.identifier, for: indexPath) as? AddServiceTableViewCell
        
        cellScreen?.screen.delegate = self
        
        cellScreen?.selectionStyle = .none
        
        cellScreen?.backgroundColor = .clear
        
        cellScreen?.setupCell(servicePresenterDTO)
        
        return cellScreen ?? UITableViewCell()
        
    }
    
}


extension AddServiceViewController: AddServiceViewCellDelegate {
    
    public func confirmationButtonTapped() {
        coordinator?.gotoListServiceHomeTabBar()
    }
       
}
