//  Created by Alessandro Comparini on 01/12/23.
//

import UIKit
import CustomComponentsSDK
import DesignerSystemSDKComponent
import HomePresenters
import ProfileSDKMain

public protocol AddScheduleViewControllerCoordinator: AnyObject {
    func gotoListScheduleHomeTabBar(_ reload: Bool)
}

public class AddScheduleViewController: UIViewController {
    public weak var coordinator: AddScheduleViewControllerCoordinator?

    public enum TagTextField: Int {
        case client = 0
        case service = 1
    }
    
    private var userIDAuth: String?
    private let tagIdentifierDock = 1000
    private var currentDate: (year: Int, month: Int, day: Int)!
        
    
//  MARK: - INITIALIZERS
    
    private var addSchedulePresenter: AddSchedulePresenter
    
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
        screen.daysDock.setScrollToItem(index: screen.daysDock.getIndexSelected() ?? 0)
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
        fetchListServices()
    }
    
    private func configDelegate() {
        screen.delegate = self
        addSchedulePresenter.outputDelegate = self
        screen.clientsList.setDelegate(self)
        screen.servicesList.setDelegate(self)
        configTextFieldDelegate()
        configCellDelegate()
    }
    
    private func configCellDelegate() {
        screen.daysDock.setDelegate(self)
        screen.hoursDock.setDelegate(self)
    }

    private func configTextFieldDelegate() {
        screen.clientTextField.setDelegate(self)
        screen.serviceTextField.setDelegate(self)
    }
    
    private func configShowComponents() {
        screen.daysDock.show()
        screen.hoursDock.show()
        screen.clientsList.show()
        screen.clientsList.reload()
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
    
    private func showPicker(id: AddSchedulePresenterImpl.PickerID) {
        switch id {
            case .clientsPicker:
                screen.clientTextField.setImage(ImageViewBuilder(systemName: "chevron.up"), .right)
                screen.clientsListView.setHidden(false)
            
            case .servicesPicker:
                screen.serviceTextField.setImage(ImageViewBuilder(systemName: "chevron.up"), .right)
                screen.servicesListView.setHidden(false)
        }
    }
    
    private func hidePickers() {
        screen.clientsListView.setHidden(true)
        screen.servicesListView.setHidden(true)
        screen.clientTextField.setImage(ImageViewBuilder(systemName: "chevron.up.chevron.down"), .right)
        screen.serviceTextField.setImage(ImageViewBuilder(systemName: "chevron.up.chevron.down"), .right)
    }
    
    private func fetchListServices() {
        Task {
            do {
                if userIDAuth == nil {
                    userIDAuth = try await ProfileSDKMain().getUserAuthenticated()
                }
                addSchedulePresenter.fetchServices(userIDAuth!)
            } catch let error  {
                print(error.localizedDescription)
            }
        }
    }

    private func makeServicesList(_ row: Int) -> UIView {
        let service = addSchedulePresenter.getService(row)
        guard let id = service?.id, let name = service?.name else { return UIView() }
        
        let view = ViewBuilder()
        let backgroundView = ViewBuilder()
            .setBorder { build in
                build.setWidth(0.5).setColor(.systemGray6)
            }
            .setConstraints { build in
                build
                    .setLeading.setTrailing.equalToSafeArea(16)
                    .setBottom.equalToSafeArea
                    .setHeight.equalToConstant(1)
            }
        backgroundView.add(insideTo: view.get)
        backgroundView.applyConstraint()
        
        let label = LabelBuilder()
            .setTextAlignment(.left)
            .setTextAttributed { build in
                build
                    .setText(text: id.description)
                    .setAttributed(key: .font, value: UIFont.boldSystemFont(ofSize: 14))
                    .setText(text: " - \(name)")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 18))
                    .setAttributed(key: .foregroundColor, value: UIColor.black.withAlphaComponent(0.6))
            }
            .setConstraints { build in
                build
                    .setLeading.equalToSafeArea(16)
                    .setTrailing.equalToSafeArea(-8)
                    .setVerticalAlignmentY.equalToSafeArea
            }
        label.add(insideTo: view.get)
        label.applyConstraint()
        
        return view.get
    }
    
}


//  MARK: - EXTESION - AddScheduleViewDelegate

extension AddScheduleViewController: AddScheduleViewDelegate {
    public func scheduleButtonTapped() {
        if let index = screen.servicesList.getIndexSelected() {
            print(addSchedulePresenter.getService(index.row) ?? "" )
        }
    }
    
    public func disableScheduleButtonTapped() {
        
    }
        
    public func backButtonTapped() {
        coordinator?.gotoListScheduleHomeTabBar(false)
    }

}

//  MARK: - EXTENSION - AddSchedulePresenterOutput
extension AddScheduleViewController: AddSchedulePresenterOutput {
    
    public func successFetchListServices() {
        screen.servicesList.show()
        screen.servicesList.reload()
    }
    
}


//  MARK: - EXTESION - ListDelegate

extension AddScheduleViewController: ListDelegate {
    public func numberOfSections(_ list: ListBuilder) -> Int { 1 }
    
    public func numberOfRows(_ list: ListBuilder, section: Int) -> Int {
        if screen.clientTextField.get.isFirstResponder {
            return addSchedulePresenter.numberOfRowsPicker(pickerID: .clientsPicker)
        }
        return addSchedulePresenter.numberOfRowsPicker(pickerID: .servicesPicker)
    }
    
    public func sectionViewCallback(_ list: ListBuilder, section: Int) -> UIView? { nil }
    
    public func rowViewCallBack(_ list: ListBuilder, section: Int, row: Int) -> UIView {
        if screen.clientTextField.get.isFirstResponder {
            return LabelBuilder(row.description).get
        }
        return makeServicesList(row)
    }
    
    public func didSelectItemAt(_ list: ListBuilder, _ section: Int, _ row: Int) {
        if let service = addSchedulePresenter.getService(row) {
            screen.serviceTextField.setText(service.name)
        }
        
    }
    
}



//  MARK: - EXTENSION - UITextFieldDelegate
extension AddScheduleViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        hidePickers()
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        showPicker(id: getPickerIdentifier(textField))
        if range.description == "{0, 1}" {
            hidePickers()
        }
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        hidePickers()
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
//        if (textField.text?.count ?? 0 > 0) {
            showPicker(id: getPickerIdentifier(textField))
//        }
    }
    
    private func getPickerIdentifier(_ textField: UITextField) -> AddSchedulePresenterImpl.PickerID {
        let textFieldTag = textField.tag
        if textFieldTag == AddScheduleViewController.TagTextField.client.rawValue {
            return .clientsPicker
        }
        return .servicesPicker
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
