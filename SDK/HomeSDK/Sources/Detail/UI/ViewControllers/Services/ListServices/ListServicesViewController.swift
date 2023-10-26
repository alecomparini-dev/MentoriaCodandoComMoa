//  Created by Alessandro Comparini on 23/10/23.
//

import UIKit
import HomePresenters
//import ProfileMain

public protocol ListServicesViewControllerCoordinator: AnyObject {
    func gotoAddService(_ servicePresenterDTO: ServicePresenterDTO?)
    func gotoViewerService(_ servicePresenterDTO: ServicePresenterDTO?)
}


public class ListServicesViewController: UIViewController {
    public weak var coordinator: ListServicesViewControllerCoordinator?
    
    private var userIDAuth: String?
    private var servicePresenterDTO: ServicePresenterDTO?
    private var listServicePresenterDTO: [ServicePresenterDTO]?
    
    private var listServicePresenter: ListServicesPresenter
    
    
//  MARK: - INITIALIZERS
    
    public init(listServicePresenter: ListServicesPresenter) {
        self.listServicePresenter = listServicePresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - SET SCREEN
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
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if listServicePresenterDTO != nil {return}
        
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            reloadTableView()
        }
    }

    
//  MARK: - PRIVATE AREA
    private func configure() {
        configDelegate()
        getUserAuth()
    }
    
    private func configDelegate() {
        screen.tableViewListServices.setDelegate(delegate: self)
        screen.tableViewListServices.setDataSource(dataSource: self)
        listServicePresenter.outputDelegate = self
    }
    
    private func getUserAuth() {
//        let profile = ProfileSDKMain().getUserAuthenticated()
        
    }
    
}


//  MARK: - EXTENSION - UITableViewDelegate
extension ListServicesViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let listServicePresenterDTO else {return}
        coordinator?.gotoViewerService(listServicePresenterDTO[indexPath.row])
    }
}


//  MARK: - EXTENSION - UITableViewDataSource
extension ListServicesViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listServicePresenterDTO?.count ?? 3
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ListServicesTableViewCell.identifier, for: indexPath) as? ListServicesTableViewCell
                
        if listServicePresenterDTO == nil {
            DispatchQueue.main.async { cell?.configSkeleton()  }
        }
        
        cell?.setupCell(listServicePresenterDTO?[indexPath.row]) { [weak self] servicePresenterDTO in
            guard let self else {return}
            coordinator?.gotoAddService(listServicePresenterDTO?[indexPath.row])
        }
        
        cell?.backgroundColor = .clear
        
        return cell ?? UITableViewCell()
    }
    
}


//  MARK: - EXTENSION - ListServicesPresenterOutput

extension ListServicesViewController: ListServicesPresenterOutput {
    public func successFetchListServices() {
        
    }
    
    public func errorFetchListServices(title: String, message: String) {
        
    }
    
    public func reloadTableView() {
        screen.tableViewListServices.get.reloadData()
    }
    
    
}
