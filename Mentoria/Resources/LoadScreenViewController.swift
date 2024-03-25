//  Created by Alessandro Comparini on 31/10/23.
//

import UIKit
import CustomComponentsSDK
import DesignerSystemSDKMain

protocol LoadScreenViewControllerCoordinator: AnyObject {
    func gotoSignIn()
}

class LoadScreenViewController: UIViewController {
    weak var coordinator: LoadScreenViewControllerCoordinator?
    
    
//  MARK: - INITIALIZERS
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchTheme()
    }
    

//  MARK: - LAZY AREA
    lazy var backgroundView: ViewBuilder = {
        let comp = ViewBuilder()
            .setBackgroundColor(hexColor: "#282A35")
            .setConstraints { build in
                build
                    .setPin.equalToSuperview
            }
        return comp
    }()
    
    lazy var titleScreen: LabelBuilder = {
        let comp = LabelBuilder()
            .setText("MENTORIA \nCODANDO COM MOA")
            .setColor(hexColor: "#FFFFFF")
            .setWeight(.bold)
            .setSize(26)
            .setNumberOfLines(2)
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(200)
                    .setHorizontalAlignmentX.equalToSafeArea
            }
        return comp
    }()
    
    lazy var instaScreen: LabelBuilder = {
        let comp = LabelBuilder()
            .setText("@codandocommoa")
            .setColor(hexColor: "#FFFFFF")
            .setWeight(.semibold)
            .setSize(20)
            .setConstraints { build in
                build
                    .setTop.equalTo(titleScreen.get, .bottom, 56)
                    .setHorizontalAlignmentX.equalToSafeArea
            }
        return comp
    }()
    
    lazy var indicatorLoading: LoadingBuilder = {
        let comp = LoadingBuilder()
            .setColor(hexColor: "#FFFFFF")
            .setStyle(.medium)
            .setStartAnimating()
            .setConstraints { build in
                build
                    .setTop.equalTo(instaScreen.get, .bottom, 32)
                    .setHorizontalAlignmentX.equalToSafeArea
            }
        return comp
    }()
    

    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        backgroundView.add(insideTo: self.view)
        titleScreen.add(insideTo: self.view)
        instaScreen.add(insideTo: self.view)
        indicatorLoading.add(insideTo: self.view)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        titleScreen.applyConstraint()
        instaScreen.applyConstraint()
        indicatorLoading.applyConstraint()
    }
    
    private func fetchTheme() {
        Task {
            await startDesignerSystem()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
                self?.coordinator?.gotoSignIn()
            })
        }
    }
    
    private func startDesignerSystem() async {
        do {
            let DSMMain = makeDSMMain()
            try await DSMMain.start()
        } catch  {
            debugPrint(error.localizedDescription)
        }
    }
    
    private func makeDSMMain() -> DesignerSystemMain {
        let themeId = Environment.variable(.defaultTheme)
        let uIdFirebase = Environment.variable(.uIdFirebase)
        let baseURL = Environment.variable(.apiBaseUrl)
        let path = K.pathGetListComponent
        let url = URL(string: "\(baseURL)\(path)")!
        
        return DesignerSystemMain(
            url: url,
            queryParameters: [
                K.Strings.themeId : themeId ,
                K.Strings.uIdFirebase : uIdFirebase
            ]
        )
    }
    
    
}
