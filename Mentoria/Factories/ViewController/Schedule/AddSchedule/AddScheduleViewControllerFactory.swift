//  Created by Alessandro Comparini on 05/12/23.
//

import Foundation

import CoreData


import HomeUI
import HomePresenters
import HomeUseCases
import HomeUseCaseGateway
import HomeNetwork
import HomeDataStorage
import DataStorageDetail

class AddScheduleViewControllerFactory {
    
    static func make() -> AddScheduleViewController {
        
        let listServicesUseCase = ListServicesUseCaseFactory.make()
        
        let httpGet = HomeNetwork()
        
        let url = makeURL()
        
        let listClientsUseCase = ListClientsUseCaseImpl(listClientGateway: RemoteListClientsUseCaseGatewayImpl(httpGet: httpGet,
                                                                                                               url: url,
                                                                                                               headers: [:],
                                                                                                               queryParameters: [:]))
        
        let coreDataProvider = CoreDataProvider(container: NSPersistentContainer(name: "ScheduleEntity"))
        
//        let homeDataStorage = HomeDataStorage(storageProvider: coreDataProvider)
        
//        let saveScheduleGateway = CoreDataSaveScheduleUseCaseGatewayImpl(dataStorageProvider: homeDataStorage)
        let saveScheduleGateway = CoreDataSaveScheduleUseCaseGatewayImpl()
        
        let saveScheduleUseCase = SaveScheduleUseCaseImpl(saveScheduleGateway: saveScheduleGateway)
        
        let addSchedulePresenter = AddSchedulePresenterImpl(listClientsUseCase: listClientsUseCase,
                                                            listServicesUseCase: listServicesUseCase, 
                                                            saveScheduleUseCase: saveScheduleUseCase)
        
        return AddScheduleViewController(addSchedulePresenter: addSchedulePresenter)
        
    }
    
    
//  MARK: - PRIVATE AREA
    
    static private func makeURL() -> URL {
        let baseURL = Environment.variable(.apiBaseUrl)
        let path = K.pathGetClients
        return URL(string: "\(baseURL)\(path)")!
    }
    
}
