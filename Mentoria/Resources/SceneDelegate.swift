//
//  SceneDelegate.swift
//  Main
//
//  Created by Alessandro Comparini on 31/08/23.
//

import UIKit
import DSMMain

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        Task {
            await startDesignerSystem()
            startScene(scene)
        }
        
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
    
    
    
//  MARK: - PRIVATE AREA
    private func startDesignerSystem() async {
        do {
            let DSMMain = makeDSMMain()
            try await DSMMain.start()
        } catch  {
            debugPrint(error.localizedDescription)
        }
        
    }
    
    private func makeDSMMain() -> DSMMain {
        let themeId = Environment.variable(.defaultTheme)
        let uIdFirebase = Environment.variable(.uIdFirebase)
        let baseURL = Environment.variable(.apiBaseUrl)
        let path = K.pathGetListComponent
        let url = URL(string: "\(baseURL)\(path)")!
        
        return DSMMain(
            url: url,
            queryParameters: [
                K.Strings.themeId : themeId ,
                K.Strings.uIdFirebase : uIdFirebase
            ]
        )
    }
    
    private func startScene(_ scene: UIScene) {
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        let win = UIWindow(windowScene: windowsScene)
        let nav = NavigationController()
        win.rootViewController = nav
        win.makeKeyAndVisible()
        window = win
        
        let coordinator = LoginCoordinator(nav)
        coordinator.start()
    }

}

