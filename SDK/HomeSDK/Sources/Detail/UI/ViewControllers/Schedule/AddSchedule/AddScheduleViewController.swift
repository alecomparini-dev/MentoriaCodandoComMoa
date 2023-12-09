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
        screen.daysDock.selectItem(currentDate.day - 1)
//        screen.daysDock.setScrollToItem(index: currentDate.day - 1)
    }
    
    
//  MARK: - DATA TRANSFER
    public func setDataTransfer(_ data: Any?) {
        
    }

    
//  MARK: - PRIVATE AREA
    private func configure() {
        configDelegate()
        configButtonDisableSchedule()
        configShowDocks()
        configIDs()
        configSizeDocks()
        configDateLabel()
        configCurrentDate()
        configInitialFetchDaysDock()
        configureAsync()
    }
    
    private func configureAsync() {
        Task {
            do {
                try await getUserAuthID()
                fetchClients()
                fetchServices()
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
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
    
    private func configShowDocks() {
        screen.daysDock.show()
        screen.hoursDock.show()
    }
    
    private func configIDs() {
        screen.daysDock.setID(AddSchedulePresenterImpl.DockID.daysDock.rawValue)
        screen.hoursDock.setID(AddSchedulePresenterImpl.DockID.hoursDock.rawValue)
        screen.clientsList.setID(AddSchedulePresenterImpl.ListID.clients.rawValue)
        screen.servicesList.setID(AddSchedulePresenterImpl.ListID.services.rawValue)
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
        screen.daysDock.setScrollToItem(index: currentDate.day - 1)
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
    
    private func showList(id: AddSchedulePresenterImpl.ListID) {
        switch id {
            case .clients:
                screen.clientTextField.setImage(ImageViewBuilder(systemName: "chevron.up"), .right)
                screen.clientsListView.setHidden(false)
                screen.clientsList.reload()
            
            case .services:
                screen.serviceTextField.setImage(ImageViewBuilder(systemName: "chevron.up"), .right)
                screen.servicesListView.setHidden(false)
                screen.servicesList.reload()
        }
    }
    
    private func hideLists() {
        screen.clientsListView.setHidden(true)
        screen.servicesListView.setHidden(true)
        screen.clientTextField.setImage(ImageViewBuilder(systemName: "chevron.up.chevron.down"), .right)
        screen.serviceTextField.setImage(ImageViewBuilder(systemName: "chevron.up.chevron.down"), .right)
    }
    
    private func getUserAuthID() async throws {
        if userIDAuth == nil {
            userIDAuth = try await ProfileSDKMain().getUserAuthenticated()
        }
    }
    
    private func fetchClients() {
        if let userIDAuth {
            addSchedulePresenter.fetchClients(userIDAuth)
        }
    }
    
    private func fetchServices() {
        if let userIDAuth {
            addSchedulePresenter.fetchServices(userIDAuth)
        }
    }
    
    private func makeLists(listID: AddSchedulePresenterImpl.ListID, _ row: Int) -> UIView {
        var id: Int?
        var name: String?
        
        if listID == .clients {
            let client = addSchedulePresenter.getClient(row)
            id = client?.id
            name = client?.name
        }
        
        if listID == .services {
            let service = addSchedulePresenter.getService(row)
            id = service?.id
            name = service?.name
        }
        
        guard let id, let name else { return UIView() }
        
        return makeListsView(id, name)
    }

    private func makeListsView(_ id: Int, _ name: String) -> UIView {
        let view = ViewBuilder()
        let backgroundView = ViewBuilder()
            .setBorder { build in
                build.setWidth(0.5).setColor(.systemGray6)
            }
            .setConstraints { build in
                build
                    .setLeading.setTrailing.equalToSafeArea(16)
                    .setBottom.equalToSafeArea
                    .setHeight.equalToConstant(0.5)
            }
        backgroundView.add(insideTo: view.get)
        backgroundView.applyConstraint()
        
        let label = LabelBuilder()
            .setTextAlignment(.left)
            .setTextAttributed { build in
                build
                    .setText(text: id.description)
                    .setAttributed(key: .font, value: UIFont.boldSystemFont(ofSize: 14))
                    .setAttributed(key: .foregroundColor, value: UIColor.black)
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
    public func resetHours() {
        if let indexSelected = screen.hoursDock.getIndexSelected() {
            screen.hoursDock.deselect(indexSelected)
        }
        
    }
    
    public func successFetchClientList() {
        screen.clientsList.show()
    }
    
    public func successFetchServiceList() {
        screen.servicesList.show()
    }
    
}


//  MARK: - EXTESION - ListDelegate

extension AddScheduleViewController: ListDelegate {
    public func numberOfSections(_ list: ListBuilder) -> Int { 1 }
    
    public func numberOfRows(_ list: ListBuilder, section: Int) -> Int {
        if list.id == AddSchedulePresenterImpl.ListID.clients.rawValue {
            return addSchedulePresenter.numberOfRowsList(listID: .clients)
        }
        return addSchedulePresenter.numberOfRowsList(listID: .services)
    }
    
    public func sectionViewCallback(_ list: ListBuilder, section: Int) -> UIView? { nil }
    
    public func rowViewCallBack(_ list: ListBuilder, section: Int, row: Int) -> UIView {
        if list.id == AddSchedulePresenterImpl.ListID.clients.rawValue {
            return makeLists(listID: .clients, row)
        }
        return makeLists(listID: .services, row)
    }
    
    public func didSelectItemAt(_ list: ListBuilder, _ section: Int, _ row: Int) {
        if list.id == AddSchedulePresenterImpl.ListID.clients.rawValue {
            if let client = addSchedulePresenter.getClient(row) {
                screen.clientTextField.setText(client.name)
            }
            return
        }
        if let service = addSchedulePresenter.getService(row) {
            screen.serviceTextField.setText(service.name)
        }
        
    }
    
}



//  MARK: - EXTENSION - UITextFieldDelegate

extension AddScheduleViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        hideLists()
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        showList(id: getPickerIdentifier(textField))
        if range.description == "{0, 1}" {
            hideLists()
        }
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        hideLists()
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        showList(id: getPickerIdentifier(textField))
    }
    
    private func getPickerIdentifier(_ textField: UITextField) -> AddSchedulePresenterImpl.ListID {
        let textFieldTag = textField.tag
        if textFieldTag == AddScheduleViewController.TagTextField.client.rawValue {
            return .clients
        }
        return .services
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
    
    public func didSelectItemAt(_ dockBuilder: DockBuilder, _ index: Int) {
        switch dockBuilder.id {
        case AddSchedulePresenterImpl.DockID.daysDock.rawValue:
            fetchHoursDock(currentDate.year, currentDate.month, index + 1)
                    
        default:
            break
        }
        
    }
    
    public func didDeselectItemAt(_ dockBuilder: DockBuilder, _ index: Int) {}
    
}
