//  Created by Alessandro Comparini on 30/08/23.
//

import UIKit

public protocol HomeViewControllerCoordinator: AnyObject {
    func gotoLogin()
}


public final class HomeViewController: UIViewController {
    public weak var coordinator: HomeViewControllerCoordinator?
    
    lazy var home: HomeView = {
        let view = HomeView()
        return view
    }()
    
    public override func loadView() {
        view = home
        navigationController?.isNavigationBarHidden = true
    }
    
    
//  MARK: - LIFE CYCLE
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        configDelegate()
    }
    
    private func configDelegate() {
        home.delegate = self
    }
}



//  MARK: - EXTENSION - HomeViewDelegate
extension HomeViewController: HomeViewDelegate {
    
    func buttonTapped() {
        coordinator?.gotoLogin()
    }
    
}



