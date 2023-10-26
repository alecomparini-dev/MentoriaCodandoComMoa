//  Created by Alessandro Comparini on 26/10/23.
//

import Foundation


public protocol ListServicesPresenterOutput: AnyObject {
    func successFetchListServices()
    func errorFetchListServices(title: String, message: String)
    func reloadTableView()
}

public class ListServicesPresenterImpl: ListServicesPresenter {
    public weak var outputDelegate: ListServicesPresenterOutput?
    
    private var filteredText = ""
    private var servicesData = [ServicePresenterDTO]()
    private var filteredServicesData = [ServicePresenterDTO]()
    
    
    public init() {}
    
    
    
    public func fetchCurrencies(_ userIDAuth: String) {
        
        
        
        self.servicesData = [
            ServicePresenterDTO(id: 1, uIDFirebase: "Ac75MOSIPBWKzzByq4Ix6G9jp7S2", name: "Desenvolvimento iOS", description: "Desenvolvimento de applicativos para IOS ", duration: "60 min", howMutch: "R$ 550,00"),
            ServicePresenterDTO(id: 2, uIDFirebase: "Ac75MOSIPBWKzzByq4Ix6G9jp7S2", name: "Desenvolvimento Android", description: "Desenvolvimento de applicativos para Android ", duration: "60 min", howMutch: "R$ 200,00"),
            ServicePresenterDTO(id: 3, uIDFirebase: "Ac75MOSIPBWKzzByq4Ix6G9jp7S2", name: "Desenvolvimento Flutter", description: "Desenvolvimento de applicativos para Flutter ", duration: "60 min", howMutch: "R$ 100,00"),
            ServicePresenterDTO(id: 4, uIDFirebase: "Ac75MOSIPBWKzzByq4Ix6G9jp7S2", name: "Desenvolvimento BackEnd Java", description: "Desenvolvimento de BackEnd Java ", duration: "60 min", howMutch: "R$ 20,00")
        ]
    }

    public func numberOfRowsInSection() -> Int {
        return getServices().count
    }
    
    public func getServices() -> [ServicePresenterDTO] {
        return filteredText.isEmpty ? servicesData : filteredServicesData
    }
    
    public func getServiceBy(index: Int) -> ServicePresenterDTO? {
        return getServices()[index]
    }
    
    public func filterServices(_ text: String) {
        filteredText = text
        self.filteredServicesData = servicesData.filter({
            $0.name?.lowercased().contains(text.lowercased()) ?? false
        })
        reloadTableView()
    }
    
    
    
//  MARK: - PRIVATE AREA
    
    private func successFetchListServices() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            outputDelegate?.successFetchListServices()
        }
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
