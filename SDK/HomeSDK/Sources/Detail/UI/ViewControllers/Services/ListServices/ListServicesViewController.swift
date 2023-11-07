//  Created by Alessandro Comparini on 23/10/23.
//

import UIKit
import HomePresenters
import ProfileSDKMain

public protocol ListServicesViewControllerCoordinator: AnyObject {
    func gotoSaveService(_ servicePresenterDTO: ServicePresenterDTO?)
    func gotoViewerService(_ servicePresenterDTO: ServicePresenterDTO?)
}


public class ListServicesViewController: UIViewController {
    public weak var coordinator: ListServicesViewControllerCoordinator?
    
    private var userIDAuth: String?
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
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if listServicePresenter.getServices() != nil {return }
        reload()
    }
    
    
//  MARK: - DATA TRANSFER
    public func setDataTransfer(_ data: Any?) {
        if let reload = data as? Bool {
            if reload {
                self.reload()
            }
        }
    }
    
    
//  MARK: - PRIVATE AREA
    private func reload() {
        setHiddenServiceCustomText(true)
        listServicePresenter.clearServices()
        reloadTableView()
        fetchListServices()
    }
    
    private func setHiddenServiceCustomText(_ flag: Bool) {
        screen.addServiceCustomText.setHidden(flag)
    }
    
    private func configure() {
        configDelegate()
    }
    
    private func configDelegate() {
        configScreenDelegate()
        configTableViewListServiceDelegate()
        configListServicePresenterDelegate()
    }
    
    private func configScreenDelegate() {
        screen.delegate = self
    }
    
    private func configTableViewListServiceDelegate() {
        screen.tableViewListServices.setDelegate(delegate: self)
        screen.tableViewListServices.setDataSource(dataSource: self)
    }
    
    private func configListServicePresenterDelegate() {
        listServicePresenter.outputDelegate = self
    }
        
    private func fetchListServices() {
        // TODO: - RETIRAR ESTE TRECHO DAQUI, USAR O PADRAO DO CLEAN ARCH
        Task {
            do {
                if userIDAuth == nil {
                    userIDAuth = try await ProfileSDKMain().getUserAuthenticated()
                }
                listServicePresenter.fetchCurrencies(userIDAuth!)
            } catch let error  {
                print(error.localizedDescription)
            }
        }
    }
    
    private func filterServices(_ text: String?) {
        guard let text else {return}
        listServicePresenter.filterServices(text)
    }
    
}


//  MARK: -
extension ListServicesViewController: ListServicesViewDelegate {
    
    public func searchTextFieldEditing(_ textField: UITextField) {
        filterServices(textField.text)
    }
    
    public func addServiceButtonTapped() {
        coordinator?.gotoSaveService(ServicePresenterDTO(uIDFirebase: userIDAuth))
    }
    
}


//  MARK: - EXTENSION - UITableViewDelegate
extension ListServicesViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return listServicePresenter.heightForRowAt()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let service = listServicePresenter.getServiceBy(index: indexPath.row) else {return}
        coordinator?.gotoViewerService(service)
    }
}


//  MARK: - EXTENSION - UITableViewDataSource
extension ListServicesViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listServicePresenter.numberOfRowsInSection()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ListServicesTableViewCell.identifier, for: indexPath) as? ListServicesTableViewCell
                
        let service: ServicePresenterDTO? = listServicePresenter.getServiceBy(index: indexPath.row)
        cell?.setupCell(service) { [weak self] in
            guard let self else {return}
            coordinator?.gotoSaveService(service)
        }
        
        return cell ?? UITableViewCell()
    }
    
}


//  MARK: - EXTENSION - ListServicesPresenterOutput

extension ListServicesViewController: ListServicesPresenterOutput {
    public func successFetchListServices() {
        filterServices(screen.searchTextField.get.text)
        reloadTableView()
        if let services = listServicePresenter.getServices() {
            setHiddenServiceCustomText(!services.isEmpty)
        }
    }
    
    public func errorFetchListServices(title: String, message: String) {
        debugPrint(message)
    }
    
    public func reloadTableView() {
        screen.tableViewListServices.get.reloadData()
    }
    
}
