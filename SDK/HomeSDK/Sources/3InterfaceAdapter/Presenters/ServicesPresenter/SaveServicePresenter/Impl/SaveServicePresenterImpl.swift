//  Created by Alessandro Comparini on 28/10/23.
//

import Foundation

import HomeUseCases

public protocol SaveServicePresenterOutput: AnyObject {
    func successSaveService()
    func errorSaveService(title: String, message: String)
    func validations(validationsError: String?, fieldsRequired: [SaveServicePresenterImpl.FieldsRequired])
    func successDisableService()
    func errorDisableService(title: String, message: String)
}


public class SaveServicePresenterImpl: SaveServicePresenter {
    public weak var outputDelegate: SaveServicePresenterOutput?
    
    public enum FieldsRequired {
        case name
        case description
        case duration
        case howMutch
    }
    
    private let saveServiceUseCase: SaveServiceUseCase
    private let disableServiceUseCase: DisableServiceUseCase
    
    public init(saveServiceUseCase: SaveServiceUseCase, disableServiceUseCase: DisableServiceUseCase) {
        self.saveServiceUseCase = saveServiceUseCase
        self.disableServiceUseCase = disableServiceUseCase
    }
    
    public func saveService(_ servicePresenterDTO: ServicePresenterDTO) {
        if !validations(servicePresenterDTO) {
            return
        }
        
        Task {
            do {
                let serviceUseCaseDTO = try await saveServiceUseCase.save(
                    ServiceUseCaseDTO(
                        uidFirebase: servicePresenterDTO.uIDFirebase,
                        id: servicePresenterDTO.id,
                        name: servicePresenterDTO.name,
                        description: servicePresenterDTO.description,
                        duration: configDuration(servicePresenterDTO.duration),
                        howMutch: configHowMutch(servicePresenterDTO.howMutch),
                        uid: servicePresenterDTO.uIDFirebase)
                )
                
                guard serviceUseCaseDTO != nil else {return errorSaveService(title: "Error", message: "Não foi possível adicionar o serviço. Favor tente novamente mais tarde") }
                
                successSaveService()
                
            } catch   {
                errorSaveService(title: "Error", message: "Não foi possível adicionar o serviço. Favor tente novamente mais tarde")
            }
        }
        
    }
    
    public func disableService(_ idService: Int, _ userIDAuth: String) {
        Task {
            do {
                let disable: Bool = try await disableServiceUseCase.disable(idService, userIDAuth)
                if disable {
                    successDisableService()
                    return
                }
            } catch let error {
                debugPrint(error.localizedDescription)
            }
            errorDisableService(title: "Erro", message: "Não foi possível deletar o serviço. Favor tente novamente mais tarde")
        }
    }
    
    public func mustBeHiddenDisableServiceButton(_ servicePresenterDTO: ServicePresenterDTO?) -> Bool {
        return servicePresenterDTO?.id == nil
    }
    
    public func removeAlphabeticCharacters(from input: String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: "[a-z A-Z$]+", options: .caseInsensitive)
            return regex.stringByReplacingMatches(in: input, options: [], range: NSRange(location: 0, length: input.count), withTemplate: "")
        } catch {
            debugPrint("Erro na expressão regular: \(error)")
            return input
        }
    }
    
    public func heightForRowAt() -> CGFloat { 610 }
    
    public func numberOfRowsInSection() -> Int { 1 }

    
    
//  MARK: - PRIVATE AREA
    private func validations(_ servicePresenterDTO: ServicePresenterDTO) -> Bool {
        var failsMessage: String?

        let fieldsRequired = isValidFieldsRequired(servicePresenterDTO)

//        if let failMsg = isValidAddress(profilePresenterDTO.address?.cep ?? "", fieldsRequired) {
//            failsMessage = "\n" + failMsg
//        }

        if failsMessage != nil || !fieldsRequired.isEmpty {
            outputDelegate?.validations(validationsError: failsMessage, fieldsRequired: fieldsRequired)
            return false
        }

        return true
    }
        
    private func isValidFieldsRequired(_ servicePresenterDTO: ServicePresenterDTO) -> [FieldsRequired] {
        var fieldsRequired: [FieldsRequired] = []
        
        if servicePresenterDTO.name?.isEmpty ?? true {
            fieldsRequired.append(.name)
        }
        
        if servicePresenterDTO.description?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            fieldsRequired.append(.description)
        }
        
        if servicePresenterDTO.duration?.isEmpty ?? true {
            fieldsRequired.append(.duration)
        }

        if servicePresenterDTO.howMutch?.isEmpty ?? true {
            fieldsRequired.append(.howMutch)
        }
        
        return fieldsRequired
    }
    
    
    private func configDuration(_ duration: String?) -> Int? {
        guard let duration else {return nil}
        return Int(removeAlphabeticCharacters(from: duration))
    }
    
    private func configHowMutch(_ howMutch: String?) -> Double? {
        guard let howMutch else {return nil}
        return Double(removeAlphabeticCharacters(from: howMutch))
    }
    
    
    
//  MARK: - RETURN CALL ADD SERVICE
    private func successSaveService() {
        DispatchQueue.main.sync { [weak self] in
            self?.outputDelegate?.successSaveService()
        }
    }
    
    private func errorSaveService(title: String, message: String) {
        DispatchQueue.main.sync { [weak self] in
            self?.outputDelegate?.errorSaveService(title: title, message: message)
        }
    }
    
//  MARK: - RETURN CALL DISABLE SERVICE
    private func successDisableService() {
        DispatchQueue.main.sync { [weak self] in
            self?.outputDelegate?.successSaveService()
        }
    }
    
    private func errorDisableService(title: String, message: String) {
        DispatchQueue.main.sync { [weak self] in
            self?.outputDelegate?.errorSaveService(title: title, message: message)
        }
    }
    
}
