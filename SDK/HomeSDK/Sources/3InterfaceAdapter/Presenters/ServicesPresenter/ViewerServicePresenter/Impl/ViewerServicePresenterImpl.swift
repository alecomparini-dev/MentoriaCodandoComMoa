//  Created by Alessandro Comparini on 27/10/23.
//

import Foundation

import HomeUseCases

public protocol ViewerServicePresenterOutput: AnyObject {
    func successDisableServices()
    func errorDisableServices(title: String, message: String)
}


public class ViewerServicePresenterImpl: ViewerServicePresenter {
    public weak var outputDelegate: ViewerServicePresenterOutput?
    private let disableServiceUseCase: DisableServiceUseCase
    
    public init(disableServiceUseCase: DisableServiceUseCase) {
        self.disableServiceUseCase = disableServiceUseCase
    }

    public func disableService(_ idService: Int, _ userIDAuth: String) {        
        Task {
            do {
                let disable: Bool = try await disableServiceUseCase.disable(idService, userIDAuth)
                if disable {
                    successDisableServices()
                    return
                }
            } catch let error {
                debugPrint(error.localizedDescription)
            }
            errorDisableServices(title: "Erro", message: "Não foi possível deletar o serviço. Favor tente novamente mais tarde")
        }
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func successDisableServices() {
        DispatchQueue.main.sync { [weak self] in
            self?.outputDelegate?.successDisableServices()
        }
    }
    
    private func errorDisableServices(title: String, message: String) {
        DispatchQueue.main.sync { [weak self] in
            self?.outputDelegate?.errorDisableServices(title: title, message: message)
        }
    }
    
    
}
