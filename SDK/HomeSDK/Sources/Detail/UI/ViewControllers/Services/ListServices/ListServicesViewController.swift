//  Created by Alessandro Comparini on 23/10/23.
//

import UIKit
import HomePresenters
import ProfileSDKMain

public protocol ListServicesViewControllerCoordinator: AnyObject {
    func gotoAddService(_ servicePresenterDTO: ServicePresenterDTO?)
    func gotoViewerService(_ servicePresenterDTO: ServicePresenterDTO?)
}


public class ListServicesViewController: UIViewController {
    public weak var coordinator: ListServicesViewControllerCoordinator?
    
    private var userIDAuth: String?
//    private var servicePresenterDTO: ServicePresenterDTO?
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
        if listServicePresenter.getServices() != nil {return}
        reloadTableView()
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
        // TODO: - RETIRAR ESTE TRECHO DAQUI, USAR O PADRAO DO CLEAN ARCH
        Task {
            do {
                self.userIDAuth = try await ProfileSDKMain().getUserAuthenticated()
                
                fetchListServices()
                
            } catch let error  {
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchListServices() {
        if let userIDAuth {
            listServicePresenter.fetchCurrencies(userIDAuth)
        }
    }
    
}


//  MARK: - EXTENSION - UITableViewDelegate
extension ListServicesViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.gotoViewerService(listServicePresenter.getServiceBy(index: indexPath.row))
    }
}


//  MARK: - EXTENSION - UITableViewDataSource
extension ListServicesViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listServicePresenter.numberOfRowsInSection() ?? 3
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ListServicesTableViewCell.identifier, for: indexPath) as? ListServicesTableViewCell
                
        if listServicePresenter.getServices() == nil {
            DispatchQueue.main.async { cell?.configSkeleton()  }
        }
        
        let service: ServicePresenterDTO? = listServicePresenter.getServiceBy(index: indexPath.row)
        cell?.setupCell(service) { [weak self] in
            guard let self else {return}
            coordinator?.gotoAddService(service)
        }
        
        
        return cell ?? UITableViewCell()
    }
    
}


//  MARK: - EXTENSION - ListServicesPresenterOutput

extension ListServicesViewController: ListServicesPresenterOutput {
    public func successFetchListServices() {
        reloadTableView()
    }
    
    public func errorFetchListServices(title: String, message: String) {
        
    }
    
    public func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.screen.tableViewListServices.get.reloadData()
        }
        
    }
    
    
}
