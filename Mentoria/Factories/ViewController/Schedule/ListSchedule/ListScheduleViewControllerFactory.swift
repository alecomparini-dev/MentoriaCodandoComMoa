//  Created by Alessandro Comparini on 01/12/23.
//

import Foundation

import HomeUI
import HomePresenters
import HomeUseCases
import HomeUseCaseGateway
import HomeRepositories
import DataStorageSDKMain

class ListScheduleViewControllerFactory {
    
    static func make() -> ListScheduleViewController {
        
        let coreDataContext = CoreDataStack.shared.context
        
        let dataStorageProvider = CoreDataStorageProvider(context: coreDataContext)
        
        let fetchRepository = CoreDataFetchScheduleRepositoryImpl(dataStorage: dataStorageProvider,
                                                                  context: coreDataContext)
        
        let listScheduleGateway =  CoreDataListScheduleUseCaseGatewayImpl(fetchRepository: fetchRepository)
        
        let listScheduleUseCase = ListScheduleUseCaseImpl(listScheduleGateway: listScheduleGateway)
        
        let listSchedulePresenter = ListSchedulePresenterImpl(listScheduleUseCase: listScheduleUseCase)
        
        return ListScheduleViewController(listSchedulePresenter: listSchedulePresenter)
        
    }
    
}
