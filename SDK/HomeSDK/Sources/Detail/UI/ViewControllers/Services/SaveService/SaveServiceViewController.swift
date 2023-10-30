//  Created by Alessandro Comparini on 24/10/23.
//

import UIKit

import HomePresenters

public protocol AddServiceViewControllerCoordinator: AnyObject {
    func gotoListServiceHomeTabBar()
}

public class SaveServiceViewController: UIViewController {
    public weak var coordinator: AddServiceViewControllerCoordinator?
    
    private struct Control {
        static var setNeedsLayout = true
    }
    
    private var constantBottom: CGFloat?
    
    private var servicePresenterDTO: ServicePresenterDTO?
    private var cellScreen: AddServiceTableViewCell?
    
    private var saveServicePresenter: SaveServicePresenter
    
    
//  MARK: - INITIALIZERS
    
    public init(saveServicePresenter: SaveServicePresenter) {
        self.saveServicePresenter = saveServicePresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public lazy var screen: SaveServiceView = {
        let view = SaveServiceView()
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
        configControlSetNeedsLayout()
        registerKeyboardNotifications()
        configDisableServiceButton()
    }
    
    private func configDisableServiceButton() {
        screen.disableServiceButton.setHidden(
            saveServicePresenter.mustBeHiddenDisableServiceButton(servicePresenterDTO)
        )
    }
    
    private func configDelegate() {
        screen.delegate = self
        screen.tableViewScreen.setDelegate(delegate: self)
        screen.tableViewScreen.setDataSource(dataSource: self)
        saveServicePresenter.outputDelegate = self
    }

    private func configControlSetNeedsLayout() {
        Control.setNeedsLayout = true
    }

    private func configCellDelegate() {
        cellScreen?.screen.delegate = self
        cellScreen?.screen.durationServiceTextField.setDelegate(self)
        cellScreen?.screen.howMutchServiceTextField.setDelegate(self)
    }
    
    private func isFirstResponderTextFields() {
        guard let cellScreen else {return}
        
        if cellScreen.screen.durationServiceTextField.get.isFirstResponder {
            setTableViewScroll(at: .bottom)
        }
        
        if cellScreen.screen.howMutchServiceTextField.get.isFirstResponder {
            setTableViewScroll(at: .bottom)
        }
    }
    
    private func setTableViewScroll(at: UITableView.ScrollPosition) {
        screen.tableViewScreen.get.scrollToRow(at: IndexPath(row: 0, section: 0), at: at, animated: true)
    }

    private func updateServicePresenterDTO() {
        servicePresenterDTO?.name = cellScreen?.screen.titleServiceTextField.get.text
        servicePresenterDTO?.description = cellScreen?.screen.descriptionServiceTextView.get.text
        servicePresenterDTO?.duration = cellScreen?.screen.durationServiceTextField.get.text
        servicePresenterDTO?.howMutch = cellScreen?.screen.howMutchServiceTextField.get.text
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
        if let constantBottom = self.constantBottom {
            screen.constraintsBottom.constant = -constantBottom
            screen.layoutIfNeeded()
            isFirstResponderTextFields()
        }
    }
    
    @objc private func keyboardWillHide() {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: { [weak self] in
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                guard let self else {return}
                screen.constraintsBottom.constant = 0
                if Control.setNeedsLayout {
                    screen.layoutIfNeeded()
                }
            }, completion: nil)
        })
    }
    
    private func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    

    
}

//  MARK: - EXTENSION - AddServiceViewDelegate
extension SaveServiceViewController: AddServiceViewDelegate {
    
    public func disableButtomTapped() {
        if let idService = servicePresenterDTO?.id, let userIDAuth = servicePresenterDTO?.uIDFirebase {
            saveServicePresenter.disableService(idService, userIDAuth)
        }
    }
    
    
    public func backButtonTapped() {
        coordinator?.gotoListServiceHomeTabBar()
    }
    
}


//  MARK: - EXTENSION - TABLEVIEW - UITableViewDelegate
extension SaveServiceViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 610
    }
}


//  MARK: - EXTENSION - UITableViewDataSource
extension SaveServiceViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        cellScreen = tableView.dequeueReusableCell(withIdentifier: AddServiceTableViewCell.identifier, for: indexPath) as? AddServiceTableViewCell
        
        configCellDelegate()
        
        cellScreen?.selectionStyle = .none
        
        cellScreen?.backgroundColor = .clear
        
        cellScreen?.setupCell(servicePresenterDTO)
        
        return cellScreen ?? UITableViewCell()
        
    }
    
}

//  MARK: - EXTENSION - 
extension SaveServiceViewController: AddServiceViewCellDelegate {
    
    public func confirmationButtonTapped() {
        Control.setNeedsLayout = false
        updateServicePresenterDTO()
        if let servicePresenterDTO {
            saveServicePresenter.saveService(servicePresenterDTO)
        }
    }
       
}


//  MARK: - EXTENSION - UITextFieldDelegate
extension SaveServiceViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let cellScreen else {return true}
        
        if cellScreen.screen.durationServiceTextField.get.isFirstResponder {
            setTableViewScroll(at: .bottom)
        }
        
        if cellScreen.screen.howMutchServiceTextField.get.isFirstResponder {
            setTableViewScroll(at: .bottom)
        }

        return true
    }
    
    
}


//  MARK: - EXTENSION - saveServicePresenterOutput
extension SaveServiceViewController: SaveServicePresenterOutput {
    public func successSaveService() {
        coordinator?.gotoListServiceHomeTabBar()
    }
    
    public func errorSaveService(title: String, message: String) {
        let alert = UIAlertController(title: "Aviso", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    public func successDisableService() {
        coordinator?.gotoListServiceHomeTabBar()
    }
    
    public func errorDisableService(title: String, message: String) {
        let alert = UIAlertController(title: "Aviso", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
}
