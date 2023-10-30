//  Created by Alessandro Comparini on 28/10/23.
//

import Foundation

import HomeUseCases

public protocol SaveServicePresenterOutput: AnyObject {
    func successSaveService()
    func errorSaveService(title: String, message: String)
    func successDisableService()
    func errorDisableService(title: String, message: String)
}


public class SaveServicePresenterImpl: SaveServicePresenter {
    
    public weak var outputDelegate: SaveServicePresenterOutput?
    
    private let saveServiceUseCase: SaveServiceUseCase
    private let disableServiceUseCase: DisableServiceUseCase
    
    public init(saveServiceUseCase: SaveServiceUseCase, disableServiceUseCase: DisableServiceUseCase) {
        self.saveServiceUseCase = saveServiceUseCase
        self.disableServiceUseCase = disableServiceUseCase
    }
    
    public func saveService(_ servicePresenterDTO: ServicePresenterDTO) {
        
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
    
    
//  MARK: - PRIVATE AREA
    
    private func configDuration(_ duration: String?) -> Int? {
        guard let duration else {return nil}
        return Int(removeAlphabeticCharacters(from: duration))
    }
    
    private func configHowMutch(_ howMutch: String?) -> Double? {
        guard let howMutch else {return nil}
        return Double(removeAlphabeticCharacters(from: howMutch))
    }
    
    private func removeAlphabeticCharacters(from input: String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: "[a-z A-Z$]+", options: .caseInsensitive)
            return regex.stringByReplacingMatches(in: input, options: [], range: NSRange(location: 0, length: input.count), withTemplate: "")
        } catch {
            debugPrint("Erro na expressão regular: \(error)")
            return input
        }
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
