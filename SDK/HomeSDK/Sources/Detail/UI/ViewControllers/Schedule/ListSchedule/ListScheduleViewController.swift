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
    
    private let listSchedulePresenter: ListSchedulePresenter
    private var itemDockActive: UIView?
    
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

    
//  MARK: - LIFE CYCLE
    public override func loadView() {
        view = screen
    }

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
        configNavigationController()
        configDelegate()
        configShowComponents()
        configSizeItemsDock()
    }
    
    private func configNavigationController() {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configDelegate() {
        screen.delegate = self
        screen.dock.setDelegate(delegate: self)
        screen.listSchedule.setDelegate(delegate: self)
    }
    
    private func configShowComponents() {
        screen.dock.show()
        screen.listSchedule.show()
    }
    
    private func configSizeItemsDock() {
        _ = listSchedulePresenter.sizeItemsDock().compactMap { (key, value) in
            screen.dock.setCustomCellSize(index: key.rawValue, value)
        }
    }
    
    private func makeCellItemDock(_ index: Int) -> UIView {
        let itemDock = ListSchedulePresenterImpl.ItemsDock(rawValue: index) ?? .currentMonth
        
        let title = listSchedulePresenter.labelItemsDock()[itemDock] ?? ""
        
        let btn = CustomButtonSecondary("  \(title)")
            .setTitleSize(14)
        
        setImageToItemsDock(itemDock, btn, title)
        
        btn.setTag(tagIdentifierItemDock)
        
        return btn.get
    }
    
    private func setImageToItemsDock(_ itemDock: ListSchedulePresenterImpl.ItemsDock, _ btn: CustomButtonSecondary, _ title: String ) {
        let systemNameImage = listSchedulePresenter.iconItemsDock()[itemDock] ?? ""
        
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


//  MARK: - EXTESION - DockDelegate

extension ListScheduleViewController: DockDelegate {
    
    public func numberOfItemsCallback() -> Int {
        return listSchedulePresenter.sizeItemsDock().count
    }
    
    public func cellCallback(_ index: Int) -> UIView {
        return makeCellItemDock(index)
    }
    
    public func customCellActiveCallback(_ cell: UIView) -> UIView? {
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
    
    public func didSelectItemAt(_ index: Int) {
        print("alguma ação de tapped")
    }
    
    public func didDeselectItemAt(_ index: Int) {
//        let item = screen.dock.getCellByIndex(index)
//        let view = (item)?.getView(tag: tagIdentifierItemDock)
//        guard let btn = view as? UIButton else { return }
//        btn.removeNeumorphism()
//        setColorItemDock("#ffffff", btn)
        print("alguma ação pra REMOÇÃO ")
    }
    
    public func setColorItemDock(_ hexColor: String, _ btn: UIButton) {
        btn.setTitleColor(UIColor.HEX(hexColor), for: .normal)
        btn.tintColor = UIColor.HEX(hexColor)
    }
}


//  MARK: - EXTESION - ListDelegate

extension ListScheduleViewController: ListDelegate {
    
    public func numberOfSections() -> Int {
        return 0
    }
        
    public func numberOfRows(section: Int) -> Int {
        switch section {
            case 0:
                return 2
            case 1:
                return 5
            case 2:
                return 3
            default:
                return 0
        }
    
//        CÓDIGO PARA PEGAR DATAS UNICAS E HORAS UNICAS, ENTAO COM ISSO CONSIGUIREI SABER QUANTAS DATAS E PARA CADA DATA QUANTAS HORAS
        
//        do {
//            let jsonData = jsonData.data(using: .utf8)!
//            let events = try JSONDecoder().decode([Event].self, from: jsonData)
//
//
//            // Dicionário para armazenar horas únicas associadas a cada data
//            var hoursByDate: [String: Set<String>] = [:]
//
//            for event in events {
//                if var hours = hoursByDate[event.data] {
//                    // Já existe uma entrada para esta data, adicione a hora ao conjunto existente
//                    hours.insert(event.hora)
//                    hoursByDate[event.data] = hours
//                } else {
//                    // Não há uma entrada para esta data, crie um novo conjunto com a hora
//                    hoursByDate[event.data] = [event.hora]
//                }
//            }
//        } catch {
//            print("Erro ao decodificar JSON: \(error)")
//        }
    }
    
    public func sectionViewCallback(section: Int) -> UIView? {
        let label = LabelBuilder(" Alessandro - \(section)")
            .setSize(24)
            .setColor(.red)
            .setWeight(.black)
            .setShadow({ build in
                build
                    .setColor(.black)
                    .setOffset(CGSize(width: 2, height: 2))
                    .setRadius(4)
            })
            .setConstraints { build in
                build.setPin.equalToSafeArea
            }
                
        return label.get
        
    }
    
    public func rowViewCallBack(section: Int, row: Int) -> UIView {
        return LabelBuilder("   section : \(section) - linha: \(row)" )
            .setColor(.white)
            .get
    }
    
    
    
}
