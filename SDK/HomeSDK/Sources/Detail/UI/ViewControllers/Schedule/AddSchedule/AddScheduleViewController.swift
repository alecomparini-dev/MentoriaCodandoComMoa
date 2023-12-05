//  Created by Alessandro Comparini on 01/12/23.
//

import UIKit
import CustomComponentsSDK
import DesignerSystemSDKComponent
import HomePresenters

public protocol AddScheduleViewControllerCoordinator: AnyObject {
    func gotoListScheduleHomeTabBar(_ reload: Bool)
}


public class AddScheduleViewController: UIViewController {
    public weak var coordinator: AddScheduleViewControllerCoordinator?
    
    private let tagIdentifierDock = 1000
    
    public enum TagTextField: Int {
        case client = 0
        case service = 1
    }
    
    
//  MARK: - INITIALIZERS
    
    private let addSchedulePresenter: AddSchedulePresenter
    
    public init(addSchedulePresenter: AddSchedulePresenter) {
        self.addSchedulePresenter = addSchedulePresenter
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
        configShowComponents()
        configDockIDs()
        configSizeDocks()
        configDateLabel()
    }
    
    private func configDelegate() {
        screen.delegate = self
        screen.picker.delegate = self
        configTextFieldDelegate()
        configCellDelegate()
    }
    
    private func configCellDelegate() {
        screen.daysDock.setDelegate(delegate: self)
        screen.hoursDock.setDelegate(delegate: self)
    }

    private func configTextFieldDelegate() {
        screen.clientTextField.setDelegate(self)
        screen.serviceTextField.setDelegate(self)
    }
    
    private func configShowComponents() {
        screen.daysDock.show()
        screen.hoursDock.show()
    }
    
    private func configDockIDs() {
        screen.daysDock.setID(AddSchedulePresenterImpl.DockID.daysDock.rawValue)
        screen.hoursDock.setID(AddSchedulePresenterImpl.DockID.hoursDock.rawValue)
    }
    
    private func configSizeDocks() {
        screen.daysDock.setCellsSize(addSchedulePresenter.sizeOfItemsDock(dockID: .daysDock))
        screen.hoursDock.setCellsSize(addSchedulePresenter.sizeOfItemsDock(dockID: .hoursDock))
    }
    
    private func configButtonDisableSchedule() {
        screen.disableScheduleButton.setHidden(
            false
//            saveServicePresenter.mustBeHiddenDisableServiceButton(servicePresenterDTO)
        )
    }
    
    private func makeCellItemDock(_ index: Int) -> UIView {
        let btn = CustomButtonSecondary("10")
            .setTitleSize(14)
            .setBorder { build in
                build
                    .setCornerRadius(12)
            }
        
        btn.setTag(tagIdentifierDock)
        
        return btn.get
    }
    
    private func configDateLabel() {
        screen.dateLabel.setText(addSchedulePresenter.getCurrentMonth())
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


//  MARK: - EXTENSION - UITextFieldDelegate
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
        screen.picker.setHidden(false)
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



//  MARK: - EXTESION - DockDelegate
extension AddScheduleViewController: DockDelegate {
    
    public func numberOfItemsCallback(_ dockerBuilder: DockBuilder) -> Int {
        if let dockID = AddSchedulePresenterImpl.DockID(rawValue: dockerBuilder.id) {
            return addSchedulePresenter.numberOfItemsDock(dockID: dockID)
        }
        return 0
    }
    
    public func cellCallback(_ dockerBuilder: DockBuilder, _ index: Int) -> UIView {
        return makeCellItemDock(index)
    }
    
    public func customCellActiveCallback(_ dockerBuilder: DockBuilder, _ cell: UIView) -> UIView? {
        let view = cell.getView(tag: tagIdentifierDock)
        guard let btn = view as? UIButton else { return nil }
        setColorItemDock("#282a36", btn)
        btn.makeBorder({ make in
            make
                .setCornerRadius(16)
        })
        btn.makeNeumorphism({ make in
            make
                .setShape(.convex)
                .setReferenceColor(hexColor: "#baa0f4")
                .setDistance(to: .light, percent: 2)
                .setDistance(to: .dark, percent: 10)
                .setBlur(to: .light, percent: 3)
                .setBlur(to: .dark, percent: 10)
                .setIntensity(to: .light, percent: 50)
                .setIntensity(to: .dark, percent: 100)
                .apply()
        })
        return btn
    }
    
    public func didSelectItemAt(_ index: Int) {}
    
    public func didDeselectItemAt(_ index: Int) {}
    
    public func setColorItemDock(_ hexColor: String, _ btn: UIButton) {
        btn.setTitleColor(UIColor.HEX(hexColor), for: .normal)
        btn.tintColor = UIColor.HEX(hexColor)
    }
}
