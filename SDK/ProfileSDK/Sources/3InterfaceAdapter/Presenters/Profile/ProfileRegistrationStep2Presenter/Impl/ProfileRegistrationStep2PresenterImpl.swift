//  Created by Alessandro Comparini on 14/10/23.
//

import Foundation
import ProfileUseCases
import ValidatorSDK

public protocol ProfileRegistrationStep2PresenterOutput: AnyObject {
    func searchCEP(success: CEPDTO?, error: String?)
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
                
                let cep = CEPDTO( CEP: cepDTO?.CEP,
                                  street: cepDTO?.street,
                                  neighborhood: cepDTO?.neighborhood,
                                  city: cepDTO?.city,
                                  stateShortname: cepDTO?.stateShortname)
                
                if cep.city == nil || (cep.city ?? "") == "" {
                    DispatchQueue.main.async { [weak self] in
                        self?.outputDelegate?.searchCEP(success: nil, error: "CEP não Localizado")
                    }
                    return
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.outputDelegate?.searchCEP(
                        success: cep,
                        error: nil
                    )
                }
                
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.outputDelegate?.searchCEP(success: nil, error: "CEP inválido ou não localizado")
                }
                
            }
        }
    }

    public func createProfile(_ profileDTO: ProfilePresenterDTO) {
        
    }

    
}
