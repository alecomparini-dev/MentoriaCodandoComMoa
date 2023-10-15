//  Created by Alessandro Comparini on 14/10/23.
//

import Foundation
import ProfileUseCases

public protocol ProfileRegistrationStep2PresenterOutput: AnyObject {
    func error(_ error: String)
    func searchCEPSuccess(_ cepDTO: CEPDTO)
}

public class ProfileRegistrationStep2PresenterImpl: ProfileRegistrationStep2Presenter {
    public weak var outputDelegate: ProfileRegistrationStep2PresenterOutput?
    
    private let searchCEPUseCase: SearchCEPUseCase
    
    public init(searchCEPUseCase: SearchCEPUseCase) {
        self.searchCEPUseCase = searchCEPUseCase
    }

    public func searchCep(_ cep: String) {
        Task {
            do {
                let cepDTO = try await searchCEPUseCase.get(cep)
                
                DispatchQueue.main.async { [weak self] in
                    self?.outputDelegate?.searchCEPSuccess(CEPDTO(
                        CEP: cepDTO?.CEP,
                        street: cepDTO?.street,
                        neighborhood: cepDTO?.neighborhood,
                        city: cepDTO?.city,
                        stateShortname: cepDTO?.stateShortname)
                    )
                }
                
            } catch let error {
                DispatchQueue.main.async { [weak self] in
                    self?.outputDelegate?.error(error.localizedDescription)
                }
                
            }
        }
    }
    
    
}
