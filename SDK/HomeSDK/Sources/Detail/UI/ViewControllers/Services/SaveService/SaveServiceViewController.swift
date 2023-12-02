//  Created by Alessandro Comparini on 24/10/23.
//

import UIKit

import HomePresenters

public protocol SaveServiceViewControllerCoordinator: AnyObject {
    func gotoListServiceHomeTabBar(_ reload: Bool)
}

public class SaveServiceViewController: UIViewController {
    public weak var coordinator: SaveServiceViewControllerCoordinator?
    
    private struct Control {
        static var setNeedsLayout = true
    }
    
    public enum TextFieldTags: Int {
        case title = 1
        case description = 2
        case duration = 3
        case howMutch = 4
    }
    
    private var constantBottom: CGFloat?
    
    private var servicePresenterDTO: ServicePresenterDTO?
    private var cellScreen: SaveServiceTableViewCell?
    
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
        configDisableServiceButton()
        configTagTextFields()
        configKeyboardNotifications()
    }
    
    private func configDelegate() {
        screen.delegate = self
        saveServicePresenter.outputDelegate = self
        screen.tableViewScreen.setDelegate(delegate: self)
        screen.tableViewScreen.setDataSource(dataSource: self)
    }
    
    private func configControlSetNeedsLayout() {
        Control.setNeedsLayout = true
    }

    private func configDisableServiceButton() {
        screen.disableServiceButton.setHidden(
            saveServicePresenter.mustBeHiddenDisableServiceButton(servicePresenterDTO)
        )
    }
    
    private func configCellScreen() {
        configCellDelegate()
        configTagTextFields()
    }
    
    private func configCellDelegate() {
        cellScreen?.screen.delegate = self
        cellScreen?.screen.titleServiceTextField.setDelegate(self)
        cellScreen?.screen.descriptionServiceTextView.setDelegate(self)
        cellScreen?.screen.durationServiceTextField.setDelegate(self)
        cellScreen?.screen.howMutchServiceTextField.setDelegate(self)
    }
    
    private func configTagTextFields() {
        cellScreen?.screen.titleServiceTextField.setTag(TextFieldTags.title.rawValue)
        cellScreen?.screen.descriptionServiceTextView.setTag(TextFieldTags.description.rawValue)
        cellScreen?.screen.durationServiceTextField.setTag(TextFieldTags.duration.rawValue)
        cellScreen?.screen.howMutchServiceTextField.setTag(TextFieldTags.howMutch.rawValue)
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
    
    private func configHowMutch(_ howMutch: String?) -> String? {
        guard let howMutch else {return nil}
        
        //TODO: CRIAR UM ARQUIVO COM TODAS AS STRINGS
        if howMutch == "Grátis" {
            return "0,00"
        }
        
        return howMutch
    }
    
    private func setFieldsRequired(fields: [SaveServicePresenterImpl.FieldsRequired]) {
        fields.forEach { field in
            switch field {
                case .name:
                    setHiddenFieldRequired(cellScreen?.screen.titleServiceFieldRequired, false)
                    screen.tableViewScreen.get.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                case .description:
                    setHiddenFieldRequired(cellScreen?.screen.descriptionFieldRequired, false)
                case .duration:
                    setHiddenFieldRequired(cellScreen?.screen.groupServicesFieldRequired, false)
                case .howMutch:
                    setHiddenFieldRequired(cellScreen?.screen.groupServicesFieldRequired, false)
            }
        }
    }
    
    private func setHiddenFieldRequired(_ requiredLabel: FieldRequiredCustomTextSecondary?, _ flag: Bool) {
        if let requiredLabel {
            requiredLabel.setHidden(flag)
        }
    }
    
    
//  MARK: - NOTIFIER KEYBOARD
    private func configKeyboardNotifications() {
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
    
    public func disableButtonTapped() {
        if let idService = servicePresenterDTO?.id, let userIDAuth = servicePresenterDTO?.uIDFirebase {
            saveServicePresenter.disableService(idService, userIDAuth)
        }
    }
    
    public func backButtonTapped() {
        coordinator?.gotoListServiceHomeTabBar(false)
    }
    
}


//  MARK: - EXTENSION - TABLEVIEW - UITableViewDelegate
extension SaveServiceViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return saveServicePresenter.heightForRowAt()
    }
}


//  MARK: - EXTENSION - UITableViewDataSource
extension SaveServiceViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saveServicePresenter.numberOfRowsInSection()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        cellScreen = tableView.dequeueReusableCell(withIdentifier: SaveServiceTableViewCell.identifier, for: indexPath) as? SaveServiceTableViewCell
        
        configCellScreen()
        
        cellScreen?.selectionStyle = .none
        
        cellScreen?.backgroundColor = .clear
        
        cellScreen?.setupCell(configSetupCell())
        
        return cellScreen ?? UITableViewCell()
        
    }
    
    private func configSetupCell() -> ServicePresenterDTO? {
        if let duration = servicePresenterDTO?.duration {
            servicePresenterDTO?.duration = saveServicePresenter.removeAlphabeticCharacters(from: duration)
        }
        
        if var howMutch = servicePresenterDTO?.howMutch {
            howMutch = configHowMutch(howMutch) ?? "0,00"
            servicePresenterDTO?.howMutch = saveServicePresenter.removeAlphabeticCharacters(from: howMutch)
        }
        
        return servicePresenterDTO
    }
        
}

//  MARK: - EXTENSION - AddServiceViewCellDelegate
extension SaveServiceViewController: SaveServiceViewCellDelegate {
    
    public func confirmationButtonTapped() {
        Control.setNeedsLayout = false
        updateServicePresenterDTO()
        if let servicePresenterDTO {
            saveServicePresenter.saveService(servicePresenterDTO)
        }
    }
       
}


//  MARK: - EXTENSION - UITextViewDelegate
extension SaveServiceViewController: UITextViewDelegate {

    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.tag == TextFieldTags.description.rawValue {
            setHiddenFieldRequired(cellScreen?.screen.descriptionFieldRequired, true)
        }

        return true
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
        
        switch textField.tag {
            case TextFieldTags.title.rawValue:
                setHiddenFieldRequired(cellScreen.screen.titleServiceFieldRequired, true)
                
            case TextFieldTags.duration.rawValue:
                setTableViewScroll(at: .bottom)
                configSetHiddenFieldRequiredGroupView(textField)
                
            case TextFieldTags.howMutch.rawValue:
                setTableViewScroll(at: .bottom)
                configSetHiddenFieldRequiredGroupView(textField)
                return validateKeyboardDecimal(text: textField.text, string)
                
            default:
                break
        }

        return true
    }
    
    private func configSetHiddenFieldRequiredGroupView(_ textField: UITextField) {
        guard let cellScreen else {return}
        if let duration = cellScreen.screen.durationServiceTextField.get.text {
            if duration.isEmpty && textField.tag != TextFieldTags.duration.rawValue {
                return
            }
        }
        
        if let howMutch = cellScreen.screen.howMutchServiceTextField.get.text {
            if howMutch.isEmpty && textField.tag != TextFieldTags.howMutch.rawValue {
                return
            }
        }
        
        setHiddenFieldRequired(cellScreen.screen.groupServicesFieldRequired, true)
    }
    
}


//  MARK: - EXTENSION - saveServicePresenterOutput
extension SaveServiceViewController: SaveServicePresenterOutput {
    
    public func validations(validationsError: String?, fieldsRequired: [SaveServicePresenterImpl.FieldsRequired]) {
        if let validationsError {
            let alert = UIAlertController(title: "Aviso", message: validationsError, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        }
        
        if !fieldsRequired.isEmpty {
            setFieldsRequired(fields: fieldsRequired)
        }
    }
    
    public func successSaveService() {
        coordinator?.gotoListServiceHomeTabBar(true)
    }
    
    public func errorSaveService(title: String, message: String) {
        let alert = UIAlertController(title: "Aviso", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    public func successDisableService() {
        coordinator?.gotoListServiceHomeTabBar(true)
    }
    
    public func errorDisableService(title: String, message: String) {
        let alert = UIAlertController(title: "Aviso", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
}
