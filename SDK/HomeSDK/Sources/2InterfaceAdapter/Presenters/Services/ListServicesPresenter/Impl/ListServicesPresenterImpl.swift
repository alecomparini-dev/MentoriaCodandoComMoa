//  Created by Alessandro Comparini on 26/10/23.
//

import Foundation

import HomeUseCases

public protocol ListServicesPresenterOutput: AnyObject {
    func successFetchListServices()
    func errorFetchListServices(title: String, message: String)
    func reloadTableView()
}

public class ListServicesPresenterImpl: ListServicesPresenter {
    public weak var outputDelegate: ListServicesPresenterOutput?
    
    private var filteredText = ""
    private var servicesData: [ServicePresenterDTO]?
    private var filteredServicesData: [ServicePresenterDTO]?
    
    private let listServicesUseCase: ListServicesUseCase
    
    public init(listServicesUseCase: ListServicesUseCase) {
        self.listServicesUseCase = listServicesUseCase
    }
    
    
//  MARK: - PUBLIC AREA
    
    public func clearServices() {
        servicesData = nil
        filteredServicesData = nil
    }

    
    public func fetchServices(_ userIDAuth: String) {

        Task {
            do {
                let servicesDTO: [ServiceUseCaseDTO]? = try await listServicesUseCase.list(userIDAuth)
                
                guard let servicesDTO else {return}
                
                self.servicesData = servicesDTO.map { service in
                    
                    return ServicePresenterDTO(
                        id: service.id,
                        uIDFirebase: service.uidFirebase,
                        name: service.name,
                        description: service.description,
                        duration: "\(service.duration ?? 0 ) min",
                        howMutch: configShowHowMutch(service.howMutch)
                    )
                }
                
                successFetchListServices()
                
            } catch let error {
                errorFetchListServices(error.localizedDescription)
            }
        }
    }

    private func configShowHowMutch(_ howMutch: Double?) -> String? {
        guard let howMutch else {return nil}
        
        if howMutch <= 0 { return "Grátis" }
        
        let howMutchConverted = NumberFormatterHandler.convertDoubleEN_USToPT_BR( "\(howMutch )" )
        
        return "R$ \(howMutchConverted ?? "0,00")"
    }

    public func heightForRowAt() -> CGFloat { 170 }
    
    public func numberOfRowsInSection() -> Int {
        return getServices()?.count ?? 3
    }
    
    public func getServices() -> [ServicePresenterDTO]? {
        return filteredText.isEmpty ? servicesData : filteredServicesData
    }
    
    public func getServiceBy(index: Int) -> ServicePresenterDTO? {
        guard let listServices = getServices() else { return nil }
        if index > listServices.count - 1 { return nil }
        return listServices[index]
    }
    
    public func filterServices(_ text: String) {
        filteredText = text
        self.filteredServicesData = servicesData?.filter({
            $0.name?.lowercased().contains(text.lowercased()) ?? false
        })
        reloadTableView()
    }
    
    
    
//  MARK: - PRIVATE AREA
    
    private func successFetchListServices() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            guard let self else {return}
            outputDelegate?.successFetchListServices()
        })
    }
    
    private func errorFetchListServices(_ error: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            outputDelegate?.errorFetchListServices(title: "Error", message: "Erro ao recuperar a lista de serviços. Favor tente mais tarde")
        }
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            outputDelegate?.reloadTableView()
        }
    }
    
    
    
    
}
