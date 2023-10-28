//  Created by Alessandro Comparini on 28/10/23.
//

import Foundation

import HomeUseCases

public protocol AddServicePresenterOutput: AnyObject {
    func successAddService()
    func errorAddService(title: String, message: String)
}


public class AddServicePresenterImpl: AddServicePresenter {
    
    public weak var outputDelegate: AddServicePresenterOutput?
    
    private let addServiceUseCase: AddServiceUseCase
    
    public init(addServiceUseCase: AddServiceUseCase) {
        self.addServiceUseCase = addServiceUseCase
    }
    
    public func addService(_ servicePresenterDTO: ServicePresenterDTO) {
        
        Task {
            do {
                let serviceUseCaseDTO = try await addServiceUseCase.add(
                    ServiceUseCaseDTO(
                        uidFirebase: servicePresenterDTO.uIDFirebase,
                        id: servicePresenterDTO.id,
                        name: servicePresenterDTO.name,
                        description: servicePresenterDTO.description,
                        duration: configDuration(servicePresenterDTO.duration),
                        howMutch: configHowMutch(servicePresenterDTO.howMutch),
                        uid: servicePresenterDTO.uIDFirebase)
                )
                
                guard let serviceUseCaseDTO else {return errorAddService(title: "Error", message: "Não foi possível adicionar o serviço. Favor tente novamente mais tarde") }
                
                successAddService()
                
            } catch   {
                errorAddService(title: "Error", message: "Não foi possível adicionar o serviço. Favor tente novamente mais tarde")
            }
        }
        
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
    
    func removeAlphabeticCharacters(from input: String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: "[a-z A-Z$]+", options: .caseInsensitive)
            return regex.stringByReplacingMatches(in: input, options: [], range: NSRange(location: 0, length: input.count), withTemplate: "")
        } catch {
            debugPrint("Erro na expressão regular: \(error)")
            return input
        }
    }
    
    private func successAddService() {
        DispatchQueue.main.sync { [weak self] in
            self?.outputDelegate?.successAddService()
        }
    }
    
    private func errorAddService(title: String, message: String) {
        DispatchQueue.main.sync { [weak self] in
            self?.outputDelegate?.errorAddService(title: title, message: message)
        }
    }
    
}
