//  Created by Alessandro Comparini on 24/10/23.
//

import UIKit

import HomePresenters

public protocol AddServiceViewControllerCoordinator: AnyObject {
    func gotoListServiceHomeTabBar()
}

public class AddServiceViewController: UIViewController {
    public weak var coordinator: AddServiceViewControllerCoordinator?
    
    private var constantBottom: CGFloat?
    
    
    private var servicePresenterDTO: ServicePresenterDTO? = ServicePresenterDTO()
    private var cellScreen: AddServiceTableViewCell?
    
    
//  MARK: - INITIALIZERS
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
    
    deinit {
        unregisterKeyboardNotifications()
        constantBottom = nil
    }
    
    
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
        registerKeyboardNotifications()
    }
    
    private func configDelegate() {
        screen.delegate = self
        screen.tableViewScreen.setDelegate(delegate: self)
        screen.tableViewScreen.setDataSource(dataSource: self)
    }
    
    
//  MARK: - NOTIFIER KEYBOARD
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        if constantBottom == nil {
            self.constantBottom = (screen.tableViewScreen.get.bounds.height - keyboardFrame.origin.y) + 75
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
