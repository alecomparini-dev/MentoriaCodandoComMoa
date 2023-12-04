//  Created by Alessandro Comparini on 05/09/23.
//

import Foundation
import ProfileUI
import CustomComponentsSDK

class SignInCoordinator: Coordinator {
    var childCoordinator: Coordinator?
    let navigationController: NavigationController
    var dataTransfer: Any?
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        childCoordinator = self
        var controller = SignInViewControllerFactory.make(callBiometricsFlow: setCallBiometricsFlow() )
        controller = navigationController.pushViewController(controller)
        controller.coordinator = self

    }
    
    
//  MARK: - PRIVATE AREA
    private func setCallBiometricsFlow() -> Bool {
        if let useBiometrics = dataTransfer as? Bool {
            return useBiometrics
        }
        return true
    }
    
}


//  MARK: - EXTENSION LoginViewControllerCoordinator
extension SignInCoordinator: SignInViewControllerCoordinator {

    func gotoSignIn() {
        let coordinator = SignUpCoordinator(navigationController)
        coordinator.start()
        childCoordinator = nil
    }
    
    func gotoHome() {
        let coordinator = HomeTabBarCoordinator(navigationController)
        coordinator.start()
        coordinator.selectedTabBarItem(2)
        childCoordinator = nil
    }
    
    func gotoForgotPassword(_ email: String?) {
        let coordinator = ForgotPasswordCoordinator(navigationController)
        coordinator.start()
        coordinator.dataTransfer = email
        childCoordinator = nil
    }

    
}
