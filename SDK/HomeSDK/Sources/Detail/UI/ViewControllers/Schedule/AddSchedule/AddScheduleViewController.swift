//  Created by Alessandro Comparini on 01/12/23.
//

import UIKit
import CustomComponentsSDK

public protocol AddScheduleViewControllerCoordinator: AnyObject {
    func gotoListScheduleHomeTabBar(_ reload: Bool)
}


public class AddScheduleViewController: UIViewController {
    public weak var coordinator: AddScheduleViewControllerCoordinator?
    
    public enum TagTextField: Int {
        case client = 0
        case service = 1
    }
    
    
    //  MARK: - INITIALIZERS
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public lazy var screen: AddScheduleView = {
        let view = AddScheduleView()
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
        
    }
    
    //  MARK: - PRIVATE AREA
    private func configure() {
        configDelegate()
        configButtonDisableSchedule()
        configShowPickers()
    }
    
    private func configDelegate() {
        screen.delegate = self
        screen.picker.delegate = self
        configTextFieldDelegate()
    }
    
    private func configTextFieldDelegate() {
        screen.clientTextField.setDelegate(self)
        screen.serviceTextField.setDelegate(self)
    }
    
    private func configButtonDisableSchedule() {
        screen.disableScheduleButton.setHidden(
            false
//            saveServicePresenter.mustBeHiddenDisableServiceButton(servicePresenterDTO)
        )
    }
    
    // ta errado isso aqui preciso falar onde quero que apareça o picker
    private func configShowPickers() {
//        screen.picker.setHidden(false)
    }
    
   
}


//  MARK: - EXTESION - AddScheduleViewDelegate
extension AddScheduleViewController: AddScheduleViewDelegate {
    public func disableScheduleButtonTapped() {
        
    }
        
    public func backButtonTapped() {
        coordinator?.gotoListScheduleHomeTabBar(false)
    }

}



//  MARK: - EXTESION - PickerDelegate
extension AddScheduleViewController: PickerDelegate {
    public func numberOfComponents() -> Int {
        1
    }
    
    public func numberOfRows(forComponent: Int) -> Int {
        4
    }
    
    public func rowViewCallBack(component: Int, row: Int) -> UIView {
        return ViewBuilder()
            .setBackgroundColor(.yellow)
            .get
    }
    
    public func didSelectRowAt(_ component: Int, _ row: Int) {
        print(component, row)
    }
    
    
}

//  MARK: - EXTENSION - asdf
extension AddScheduleViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        screen.picker.setHidden(true)
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        showTopAnchor(textField)

        if range.description == "{0, 1}" {
            screen.picker.setHidden(true)
        }
        
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        screen.picker.setHidden(true)
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField.text?.count ?? 0 > 0) {
            screen.picker.setHidden(false)
            showTopAnchor(textField)
        }
    }
    
    private func showTopAnchor(_ textField: UITextField) {
        switch textField.tag {
            case TagTextField.client.rawValue:
                screen.picker.show()
                screen.setTopAnchorClient()
                    
            case TagTextField.service.rawValue:
                screen.picker.show()
                screen.setTopAnchorService()
                
            default:
                break
        }
    }
    
}
