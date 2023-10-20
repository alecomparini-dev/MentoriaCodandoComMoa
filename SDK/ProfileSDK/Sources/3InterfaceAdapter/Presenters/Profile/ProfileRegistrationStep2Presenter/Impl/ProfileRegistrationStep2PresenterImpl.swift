//  Created by Alessandro Comparini on 14/10/23.
//

import Foundation
import ProfileUseCases
import ValidatorSDK

public protocol ProfileRegistrationStep2PresenterOutput: AnyObject {
    func searchCEP(success: CEPDTO?, error: String?)
    func validations(validationsError: String?, fieldsRequired: [ProfileRegistrationStep2PresenterImpl.FieldsRequired])
}

public class ProfileRegistrationStep2PresenterImpl: ProfileRegistrationStep2Presenter {
    public weak var outputDelegate: ProfileRegistrationStep2PresenterOutput?
    
    public enum FieldsRequired {
        case cep
        case number
        case street
    }
    
    private let searchCEPUseCase: SearchCEPUseCase
    private let cepMask: Masks
    
    public init(searchCEPUseCase: SearchCEPUseCase, cepMask: Masks) {
        self.searchCEPUseCase = searchCEPUseCase
        self.cepMask = cepMask
    }
    
    public func searchCep(_ cep: String) {
        Task {
            do {
                let cepDTO = try await searchCEPUseCase.get(cep)
                
                let cep = CEPDTO(CEP: cepDTO?.CEP,
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

    public func createProfile(_ profilePresenterDTO: ProfilePresenterDTO) {
        if !validations(profilePresenterDTO) {
            return
        }
    }
    
    public func setCEPMaskWithRange(_ range: NSRange, _ string: String) -> String? {
        return cepMask.formatStringWithRange(range: range, string: string)
    }
    
    
//  MARK: - PRIVATE AREA
    private func validations(_ profilePresenterDTO: ProfilePresenterDTO) -> Bool {
        var failsMessage: String?
        
        let fieldsRequired = isValidFieldsRequired(profilePresenterDTO)
        
        if let failMsg = isValidAddress(profilePresenterDTO.address?.cep ?? "", fieldsRequired) {
            failsMessage = "\n" + failMsg
        }
                
        if failsMessage != nil || !fieldsRequired.isEmpty {
            outputDelegate?.validations(validationsError: failsMessage, fieldsRequired: fieldsRequired)
            return false
        }
        
        return true
    }
    
    
    private func isValidFieldsRequired(_ profilePresenterDTO: ProfilePresenterDTO) -> [FieldsRequired] {
        var fieldsRequired: [FieldsRequired] = []
        
        if profilePresenterDTO.address?.cep?.isEmpty ?? true {
            fieldsRequired.append(.cep)
        }
        
        if profilePresenterDTO.address?.number?.isEmpty ?? true {
            fieldsRequired.append(.number)
        }

        if profilePresenterDTO.address?.street?.isEmpty ?? true {
            fieldsRequired.append(.street)
        }
        
        return fieldsRequired
    }
    
    private func isValidAddress(_ cep: String, _ fieldsRequired: [FieldsRequired]) -> String? {
        
        if let failMsg = isValidCEP(cep) {
            return failMsg
        }
        
        if fieldsRequired.contains(where: { $0 == .street}) {
            return "Endereço obrigatório.\nFavor pesquisar CEP"
        }
        return nil
    }

    
    private func isValidCEP(_ cep: String) -> String? {
        if cep.isEmpty {return nil}
        let cellPhone = cep.replacingOccurrences(of: "-", with: "")
        
        if cellPhone.count != 8 {
            return "CEP inválido"
        }
        return nil
    }

    
}
