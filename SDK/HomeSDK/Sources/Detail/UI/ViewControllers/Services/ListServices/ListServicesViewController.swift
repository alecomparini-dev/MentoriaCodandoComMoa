//  Created by Alessandro Comparini on 23/10/23.
//

import UIKit
import HomePresenters

public protocol ListServicesViewControllerCoordinator: AnyObject {
    func gotoAddService(_ servicePresenterDTO: ServicePresenterDTO?)
    func gotoViewerService(_ servicePresenterDTO: ServicePresenterDTO?)
}


public class ListServicesViewController: UIViewController {
    public weak var coordinator: ListServicesViewControllerCoordinator?
    
    private var servicePresenterDTO: ServicePresenterDTO?
    private var listServicePresenterDTO: [ServicePresenterDTO]?
    
    
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
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if listServicePresenterDTO != nil {return}
        
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            screen.tableViewListServices.get.reloadData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.listServicePresenterDTO = [
                    ServicePresenterDTO(id: 1, uIDFirebase: "", name: "Desenvolvimento iOS", description: "Desenvolvimento de applicativos para IOS ", duration: "60 min", howMutch: "R$ 550,00"),
                    ServicePresenterDTO(id: 2, uIDFirebase: "", name: "Desenvolvimento Android", description: "Desenvolvimento de applicativos para IOS ", duration: "60 min", howMutch: "R$ 200,00"),
                    ServicePresenterDTO(id: 3, uIDFirebase: "", name: "Desenvolvimento Flutter", description: "Desenvolvimento de applicativos para IOS ", duration: "60 min", howMutch: "R$ 100,00"),
                    ServicePresenterDTO(id: 4, uIDFirebase: "", name: "Desenvolvimento BackEnd Java", description: "Desenvolvimento de applicativos para IOS ", duration: "60:00", howMutch: "R$ 20,00")
                ]
                self.screen.tableViewListServices.get.reloadData()
            })
            
        }
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
