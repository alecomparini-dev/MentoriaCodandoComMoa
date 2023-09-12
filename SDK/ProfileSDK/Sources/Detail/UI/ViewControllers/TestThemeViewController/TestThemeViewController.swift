//
//  TestThemeViewController.swift
//  DetailLayer
//
//  Created by Alessandro Comparini on 12/09/23.
//

import UIKit
import CustomComponentsSDK
import DSMMain


public final class TestThemeViewController: UIViewController {
    private var lightState = true
    private var themeId = 1
    
    lazy var screen: TestThemeView = {
        let view = TestThemeView()
        return view
    }()
    
    
    //  MARK: - LIFE CYCLE
    
    public override func loadView() {
        self.view = self.screen
        overrideUserInterfaceStyle = .light
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
//  MARK: - PRIVATE AREA
    private func configure() {
        screen.popUpSelectTheme.get.showsMenuAsPrimaryAction = true
        screen.popUpSelectTheme.get.menu = createMenu()
    }
    
    
    
//  MARK: - CHANGE THEME AREA
    private func optionClosure(_ action: UIAction) {
        themeId = 1
        if action.title == "Dark" {
            themeId = 2
        }
        startDesignerSystem()
    }
    
    private func createMenu() -> UIMenu {
        let menu = UIMenu(options: .displayInline , children: [
            UIAction(title: "Light", state: (themeId == 1) ? .on : .off, handler: optionClosure ),
            UIAction(title: "Dark" , state: (themeId == 2) ? .on : .off, handler: optionClosure ),
        ])
        return menu
    }
    
    private func reloadView() {
        screen = TestThemeView()
        view = screen
        configure()
        if themeId == 2 {
            screen.popUpSelectTheme.setTitle(" Dark")
            screen.themeSelected.setText("Voce selecionou: Dark")
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
        
    }
    
    private func startDesignerSystem()  {
        Task {
            do {
                let DSMMain = makeDSMMain()
                try await DSMMain.start()
                reloadView()
            } catch  {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    private func makeDSMMain() -> DSMMain {
        let uIdFirebase = "CodandoComMoa"
//        let uIdFirebase = Environment.variable
        let baseURL = "http://mentoria.codandocommoa.com.br"
        let path = "/Api/ThemeComponent/GetListaThemeComponent"
        let url = URL(string: "\(baseURL)\(path)")!
        
        return DSMMain(
            url: url,
            queryParameters: [
                "themeId" : "\(self.themeId)" ,
                "uIdFirebase" : uIdFirebase
            ]
        )
    }
    
}
