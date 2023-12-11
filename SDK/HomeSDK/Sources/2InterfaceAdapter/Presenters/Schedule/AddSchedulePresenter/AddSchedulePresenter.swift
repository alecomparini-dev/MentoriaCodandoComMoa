//  Created by Alessandro Comparini on 05/12/23.
//

import Foundation

import HomeUseCases

public protocol AddSchedulePresenter {
    var outputDelegate: AddSchedulePresenterOutput? { get set }
    
    func saveSchedule(_ schedule: ScheduleUseCaseDTO)
    
    func fetchClients(_ userIDAuth: String)
    func getClient(_ index: Int) -> ClientListPresenterDTO?
    
    func fetchServices(_ userIDAuth: String)
    func getService(_ index: Int) -> ServiceListPresenterDTO?
    
    func fetchDayDock(_ year: Int, _ month: Int)
    func fetchHourDock(_ year: Int, _ month: Int, _ day: Int)
    
    func getDayDock(_ index: Int) -> DateDockPresenterDTO?
    func getHourDock(_ index: Int) -> HourDockPresenterDTO?
    
    func numberOfRowsList(listID: AddSchedulePresenterImpl.ListID) -> Int
    func numberOfItemsDock(dockID: AddSchedulePresenterImpl.DockID) -> Int
    
    func sizeOfItemsDock(dockID: AddSchedulePresenterImpl.DockID) -> CGSize
    
    func getCurrentDate() -> (year: Int, month: Int, day: Int)
    func getMonthName(_ date: Date?) -> String
    func getDayWeekName(_ date: String) -> String?
    
}
