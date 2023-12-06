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

    public enum TagTextField: Int {
        case client = 0
        case service = 1
    }
    
    private let tagIdentifierDock = 1000
    private var currentDate: (year: Int, month: Int, day: Int)!
        
    
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
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setSelectionCurrentDay()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        screen.daysDock
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
        configCurrentDate()
        configInitialFetchDaysDock()
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
    
    private func configDateLabel() {
        screen.dateLabel.setText(addSchedulePresenter.getMonthName(nil))
    }

    private func configCurrentDate() {
        currentDate = addSchedulePresenter.getCurrentDate()
    }
    
    private func setSelectionCurrentDay() {
        screen.daysDock.selectItem(currentDate.day - 1)
        fetchHoursDock(currentDate.year, currentDate.month, currentDate.day)
    }
    
    private func configInitialFetchDaysDock() {
        if let year = currentDate?.year, let month = currentDate?.month {
            fetchDaysDock(year, month)
        }
    }
    
    private func fetchDaysDock(_ year: Int, _ month: Int) {
        addSchedulePresenter.fetchDayDock(year, month)
    }
    
    private func fetchHoursDock(_ year: Int, _ month: Int, _ day: Int) {
        addSchedulePresenter.fetchHourDock(year, month, day)
        screen.hoursDock.reload()
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

    private func makeAddScheduleDaysDockView(_ dockBuilder: DockBuilder, _ index: Int) -> AddScheduleDaysDockView {
        guard let dayDockPresenterDTO = addSchedulePresenter.getDayDock(index) else { return AddScheduleDaysDockView("","") }

        guard let day = dayDockPresenterDTO.day, let dayWeek = dayDockPresenterDTO.dayWeek  else { return AddScheduleDaysDockView("","") }
        
        let daysDockView = AddScheduleDaysDockView( day , dayWeek )
        
        daysDockView.setTag(tagIdentifierDock)
        
        if dayDockPresenterDTO.disabled {
            daysDockView.setAlpha(0.4)
            dockBuilder.setDisableUserInteraction(cells: [index])
        }
        
        return daysDockView
    }
        
    private func makeAddScheduleHoursDockView(_ dockBuilder: DockBuilder, _ index: Int) -> AddScheduleHoursDockView {
        
        guard let hourDockDTO = addSchedulePresenter.getHourDock(index) else { return AddScheduleHoursDockView("") }
        
        let hoursDockView = AddScheduleHoursDockView("\(hourDockDTO.hour ?? ""):\(hourDockDTO.minute ?? "")")
        
        hoursDockView.setTag(tagIdentifierDock)
        
        if hourDockDTO.disabled {
            hoursDockView.setAlpha(0.4)
            dockBuilder.setDisableUserInteraction(cells: [index])
        }
        
        return hoursDockView
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
        return LabelBuilder("Alessandro Teste")
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
    
}



//  MARK: - EXTESION - DockDelegate
extension AddScheduleViewController: DockDelegate {
    
    public func numberOfItemsCallback(_ dockBuilder: DockBuilder) -> Int {
        if let dockID = AddSchedulePresenterImpl.DockID(rawValue: dockBuilder.id) {
            return addSchedulePresenter.numberOfItemsDock(dockID: dockID)
        }
        return 0
    }
    
    public func cellCallback(_ dockBuilder: DockBuilder, _ index: Int) -> UIView {
        
        switch dockBuilder.id {
            case AddSchedulePresenterImpl.DockID.daysDock.rawValue:
                return makeAddScheduleDaysDockView(dockBuilder, index)
            
            case AddSchedulePresenterImpl.DockID.hoursDock.rawValue:
                return makeAddScheduleHoursDockView(dockBuilder, index)
                
            default:
                break
        }
        
        return UIView()
    }
    
    public func customCellActiveCallback(_ dockBuilder: DockBuilder, _ cell: UIView) -> UIView? {
        let view = cell.getView(tag: tagIdentifierDock)
        
        if let addDays = view as? AddScheduleDaysDockView {
            addDays.dayLabel.setColor(hexColor: "#282a36")
            addDays.dayWeakLabel.setColor(UIColor.HEX("#282a36").withAlphaComponent(0.8))
            addDays.backgroundView.get.makeNeumorphism({ make in
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
        }
        
        if let addHours = view as? AddScheduleHoursDockView {
            addHours.hourLabel.setColor(hexColor: "#282a36")
                .setWeight(.semibold)
            
            addHours.backgroundView.get.makeNeumorphism({ make in
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
        }
        
        return nil
    }
    
    public func didSelectItemAt(_ index: Int) {}
    
    public func didDeselectItemAt(_ index: Int) {}
    
}
