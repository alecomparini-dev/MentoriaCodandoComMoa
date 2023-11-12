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
                        duration: Int(servicePresenterDTO.duration ?? ""),
                        howMutch: NumberFormatterHandler.convertDoublePT_BRToEN_US(servicePresenterDTO.howMutch),
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

        if let failMsg = isValidDuration(servicePresenterDTO.duration ?? "") {
            failsMessage = "\n" + failMsg
        }
        
        if let failMsg = isValidHowMutch(servicePresenterDTO.howMutch ?? "") {
            failsMessage = (failsMessage ?? "") + "\n" + failMsg
        }

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
    
    private func isValidDuration(_ duration: String?) -> String? {
        guard let duration, !duration.isEmpty else {return nil}
        
        guard let duration = Int(duration) else { return "Duração não é um número válido" }
        
        if duration < 1 { return "Serviço precisa ter duração"}
        
        return nil
    }
    
    private func isValidHowMutch(_ howMutch: String?) -> String? {
        guard let howMutch, !howMutch.isEmpty else {return nil}
        
        guard NumberFormatterHandler.convertDoublePT_BRToEN_US(howMutch) != nil else { return "Valor não é um número válido" }
        
        return nil
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
            self?.outputDelegate?.successDisableService()
        }
    }
    
    private func errorDisableService(title: String, message: String) {
        DispatchQueue.main.sync { [weak self] in
            self?.outputDelegate?.errorDisableService(title: title, message: message)
        }
    }
    
}
