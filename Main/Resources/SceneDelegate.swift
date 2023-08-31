//
//  SceneDelegate.swift
//  Main
//
//  Created by Alessandro Comparini on 31/08/23.
//

import UIKit
import ProfileUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        let win = UIWindow(windowScene: windowsScene)
        let vc = LoginViewController()
        win.rootViewController = vc
        win.makeKeyAndVisible()
        window = win
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }

}

