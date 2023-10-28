//  Created by Alessandro Comparini on 25/10/23.
//


import UIKit

import HomePresenters

public protocol ViewerServiceViewControllerCoordinator: AnyObject {
    func gotoEditService(_ servicePresenterDTO: ServicePresenterDTO?)
    func gotoListServiceHomeTabBar(_ vc: UIViewController, _ reloadTable: Bool)
    func freeMemoryCoordinator()
}


public class ViewerServiceViewController: UIViewController {
    public weak var coordinator: ViewerServiceViewControllerCoordinator?
    
    private var servicePresenterDTO: ServicePresenterDTO?
    
    private var viewerServicePresenter: ViewerServicePresenter
    
    
//  MARK: - INITIALIZERS
    
    public init(viewerServicePresenter: ViewerServicePresenter) {
        self.viewerServicePresenter = viewerServicePresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public lazy var screen: ViewerServiceView = {
        let view = ViewerServiceView()
        return view
    }()

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
//  MARK: - LIFE CYCLE

    public override func loadView() {
        self.view = screen
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.freeMemoryCoordinator()
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        configDelegate()
    }
    
    private func configDelegate() {
        configScreenDelegate()
        configBottomSheetDelegate()
        configOutputPresenterDelegate()
    }
    
    private func configScreenDelegate() {
        screen.delegate = self
    }
    
    private func configBottomSheetDelegate() {
        if #available(iOS 15.0, *) {
            if let sheet = self.sheetPresentationController {
                sheet.delegate = self
            }
        }
    }
    
    private func configOutputPresenterDelegate() {
        viewerServicePresenter.outputDelegate = self
    }
    

//  MARK: - DATA TRANSFER
    public func setDataTransfer(_ data: Any?) {
        if let service = data as? ServicePresenterDTO {
            self.servicePresenterDTO = service
            populateFields()
        }
    }
    
    private func populateFields() {
        screen.titleServiceLabel.setText(servicePresenterDTO?.name)
        screen.subTitleServiceLabel.setInsertText(servicePresenterDTO?.description)
        screen.durationLabel.setText(servicePresenterDTO?.duration)
        screen.howMutchLabel.setText(servicePresenterDTO?.howMutch)
    }

    
}


//  MARK: - EXTENSION - ViewerServiceViewDelegate
extension ViewerServiceViewController: ViewerServiceViewDelegate {
    public func disableButtomTapped() {
        guard let id = servicePresenterDTO?.id, let userIDAuth = servicePresenterDTO?.uIDFirebase else { return}
        viewerServicePresenter.disableService(id, userIDAuth)
    }
    
    public func backButtonTapped() {
        coordinator?.gotoListServiceHomeTabBar(self, false)
    }
    
    public func editButtonTapped() {
        coordinator?.gotoEditService(servicePresenterDTO)
    }
    
    
}



//  MARK: - EXTENSION - ViewerServicePresenterOutput
extension ViewerServiceViewController: ViewerServicePresenterOutput {
    
    public func successDisableServices() {
        coordinator?.gotoListServiceHomeTabBar(self, true)
    }
    
    public func errorDisableServices(title: String, message: String) {
        debugPrint(message)
    }
    
    
}


//  MARK: - EXTENSION - UISheetPresentationControllerDelegate
extension ViewerServiceViewController: UISheetPresentationControllerDelegate {
 
    @available(iOS 15.0, *)
    public func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        if sheetPresentationController.selectedDetentIdentifier == .medium {
            screen.editButtom.setHidden(true)
            return
        }
        screen.editButtom.setHidden(false)
    }
    
}
