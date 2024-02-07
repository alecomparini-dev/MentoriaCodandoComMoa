//  Created by Alessandro Comparini on 29/11/23.
//

import UIKit
import CustomComponentsSDK
import DesignerSystemSDKComponent
import HomePresenters

public protocol ListScheduleViewControllerCoordinator: AnyObject {
    func gotoAddSchedule()
}

public final class ListScheduleViewController: UIViewController {
    public weak var coordinator: ListScheduleViewControllerCoordinator?
    
    private let tagIdentifierItemDock = 100
    private var itemDockActive: UIView?
    
    
//  MARK: - INITIALIZERS
    
    private var listSchedulePresenter: ListSchedulePresenter
    
    public init(listSchedulePresenter: ListSchedulePresenter) {
        self.listSchedulePresenter = listSchedulePresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var screen: ListScheduleView = {
        let view = ListScheduleView()
        return view
    }()

    
//  MARK: - STYLE
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
//  MARK: - LIFE CYCLE
    public override func loadView() {
        view = screen
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        screen.configStyleOnComponents()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
//  MARK: - DATA TRANSFER
    public func setDataTransfer(_ data: Any?) {
        if let reload = data as? Bool {
            if reload { self.reload() }
        }
    }
    
//  MARK: - PRIVATE AREA
    private func configure() {
        configNavigationController()
        configDelegate()
        configShowComponents()
        configSizeItemsFilterDock()
        //TODO: REMOVER PARA DPS QUE FIZER O LOAD PELO PRESENTER
        activeCurrentMonthItemFilterDock()
        fetchSchedules()
    }
    
    private func configNavigationController() {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configDelegate() {
        screen.delegate = self
        configOutputPresenterDelegate()
        configCellDelegate()
    }
    
    private func configOutputPresenterDelegate() {
        listSchedulePresenter.outputDelegate = self
    }
    
    private func configCellDelegate() {
        screen.filterDock.setDelegate(self)
        screen.listSchedule.setDelegate(self)
    }
    
    private func configShowComponents() {
        screen.filterDock.show()
        screen.listSchedule.show()
    }
    
    private func configSizeItemsFilterDock() {
        _ = listSchedulePresenter.sizeItemsFilterDock().compactMap { (key, value) in
            screen.filterDock.setCustomCellSize(index: key.rawValue, value)
        }
    }
    
    private func activeCurrentMonthItemFilterDock() {
//        screen.filterDock.setDisableUserInteraction(cells: [0])
        screen.filterDock.selectItem(0)
    }
    
    private func fetchSchedules() {
        listSchedulePresenter.fetchSchedule()
    }
    
    private func reload() {
        fetchSchedules()
    }
    
    private func makeCellItemDock(_ index: Int) -> UIView {
        let itemDock = ListSchedulePresenterImpl.ItemsFilterDock(rawValue: index) ?? .currentMonth
        
        let title = listSchedulePresenter.labelItemsFilterDock()[itemDock] ?? ""
        
        let btn = CustomButtonSecondary("  \(title)")
            .setIsUserInteractionEnabled(false)
            .setTitleSize(14)
        
        setImageToItemsDock(itemDock, btn, title)
        
        btn.setTag(tagIdentifierItemDock)
        
        return btn.get
    }
    
    private func setImageToItemsDock(_ itemDock: ListSchedulePresenterImpl.ItemsFilterDock, _ btn: CustomButtonSecondary, _ title: String ) {
        
        let systemNameImage = listSchedulePresenter.iconItemsFilterDock()[itemDock] ?? ""
        
        let img = ImageViewBuilder()
            .setImage(systemName: systemNameImage)
            .setContentMode(.center)
            .setSize(14)
        
        btn.setImageButton(img)
    }
    
}


//  MARK: - EXTESION - ListScheduleViewDelegate
extension ListScheduleViewController: ListScheduleViewDelegate {
    
    func addScheduleFloatButtonTapped() {
        coordinator?.gotoAddSchedule()
    }
       
}


//  MARK: - EXTESION - ListSchedulePresenterOutput
extension ListScheduleViewController: ListSchedulePresenterOutput {
    
    public func successFetchSchedule() {
        screen.listSchedule.reload()
    }
    
}


//  MARK: - EXTESION - DockDelegate

extension ListScheduleViewController: DockDelegate {
    
    public func numberOfItemsCallback(_ dockerBuilder: DockBuilder) -> Int {
        return listSchedulePresenter.numberOfItemsFilterDock()
    }
    
    public func cellCallback(_ dockerBuilder: DockBuilder, _ index: Int) -> UIView {
        return makeCellItemDock(index)
    }
    
    public func customCellActiveCallback(_ dockerBuilder: DockBuilder, _ cell: UIView) -> UIView? {
        let view = cell.getView(tag: tagIdentifierItemDock)
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
    
    public func didSelectItemAt(_ dockerBuilder: DockBuilder, _ index: Int) {
        
    }
    
    public func didDeselectItemAt(_ dockerBuilder: DockBuilder, _ index: Int) {
        
    }
    
    public func setColorItemDock(_ hexColor: String, _ btn: UIButton) {
        btn.setTitleColor(UIColor.HEX(hexColor), for: .normal)
        btn.tintColor = UIColor.HEX(hexColor)
    }
}


//  MARK: - EXTESION - ListDelegate

extension ListScheduleViewController: ListDelegate {
    
    public func numberOfSections(_ list: ListBuilder) -> Int {
        return listSchedulePresenter.numberOfSectionsSchedule()
    }
        
    public func numberOfRows(_ list: ListBuilder, section: Int) -> Int {
        return listSchedulePresenter.numberOfRowsSchedule(section)
    }
    
    public func sectionViewCallback(_ list: ListBuilder, section: Int) -> UIView? {
        let section: SectionSchedules = listSchedulePresenter.getSectionSchedule(section)
        let sectionView = ListScheduleSectionView(section: section)
        if section.dayTitle == DateHandler.getCurrentDate().day.description {
            sectionView.triangleImage.setTintColor(hexColor: "#fa79c7")
        }
        return sectionView
    }
    
    public func rowViewCallBack(_ list: ListBuilder, section: Int, row: Int) -> UIView {
        let row: SchedulePresenterDTO = listSchedulePresenter.getRowSchedule(section, row)
        return ListScheduleRowView(schedulePresenterDTO: row)
    }
    
}
