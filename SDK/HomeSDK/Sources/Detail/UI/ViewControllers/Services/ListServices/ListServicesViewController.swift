//  Created by Alessandro Comparini on 23/10/23.
//

import UIKit

public protocol ListServicesViewControllerCoordinator: AnyObject {
    func gotoSaveService()
    func gotoViewerService()
}


public class ListServicesViewController: UIViewController {
    public weak var coordinator: ListServicesViewControllerCoordinator?
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public lazy var screen: ListServicesView = {
        let view = ListServicesView()
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
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        configDelegate()
    }
    
    private func configDelegate() {
        screen.tableViewListServices.setDelegate(delegate: self)
        screen.tableViewListServices.setDataSource(dataSource: self)
    }
    
    
}



//  MARK: - EXTENSION - UITableViewDelegate
extension ListServicesViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}


//  MARK: - EXTENSION - UITableViewDataSource
extension ListServicesViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        return cell
    }
    
}
