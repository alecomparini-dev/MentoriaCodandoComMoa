//  Created by Alessandro Comparini on 05/12/23.
//

import Foundation

import CoreData

import HomeUI
import HomePresenters
import HomeUseCases
import HomeUseCaseGateway
import HomeNetwork
import HomeRepositories
import DataStorageSDK

class SaveScheduleViewControllerFactory {
    
    static func make() -> SaveScheduleViewController {
        
        let listServicesUseCase = ListServicesUseCaseFactory.make()
        
        let httpGet = HomeNetwork()
        
        let url = makeURL()
        
        let listClientsUseCase = ListClientsUseCaseImpl(listClientGateway: RemoteListClientsUseCaseGatewayImpl(
            httpGet: httpGet,
            url: url,
            headers: [:],
            queryParameters: [:]))
        
        let coreDataContext = CoreDataStack.shared.context
        
        let dataStorageProvider = CoreDataStorageProvider(context: coreDataContext)
        
        let createRepository = CoreDataCreateScheduleRepositoryImpl(dataStorage: dataStorageProvider,
                                                              context: coreDataContext)
        
        let saveScheduleGateway = CoreDataSaveScheduleUseCaseGatewayImpl(createRepository: createRepository)
        
        let saveScheduleUseCase = SaveScheduleUseCaseImpl(saveScheduleGateway: saveScheduleGateway)
        
        let saveSchedulePresenter = SaveSchedulePresenterImpl(listClientsUseCase: listClientsUseCase,
                                                            listServicesUseCase: listServicesUseCase, 
                                                            saveScheduleUseCase: saveScheduleUseCase)
        
        return SaveScheduleViewController(saveSchedulePresenter: saveSchedulePresenter)
    }
    
    
//  MARK: - PRIVATE AREA
    
    static private func makeURL() -> URL {
        let baseURL = Environment.variable(.apiBaseUrl)
        let path = K.pathGetClients
        return URL(string: "\(baseURL)\(path)")!
    }
    
}
