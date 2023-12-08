//  Created by Alessandro Comparini on 05/12/23.
//

import Foundation


public protocol AddSchedulePresenter {
    var outputDelegate: AddSchedulePresenterOutput? { get set }
    
    func fetchServices(_ userIDAuth: String)
    func getService(_ index: Int) -> ServicesPickerPresenterDTO?
    
    func fetchDayDock(_ year: Int, _ month: Int)
    func fetchHourDock(_ year: Int, _ month: Int, _ day: Int)
    
    func getDayDock(_ index: Int) -> DateDockPresenterDTO?
    func getHourDock(_ index: Int) -> HourDockPresenterDTO?
    
    func numberOfRowsPicker(pickerID: AddSchedulePresenterImpl.PickerID) -> Int
    func numberOfItemsDock(dockID: AddSchedulePresenterImpl.DockID) -> Int
    
    func sizeOfItemsDock(dockID: AddSchedulePresenterImpl.DockID) -> CGSize
    
    func getCurrentDate() -> (year: Int, month: Int, day: Int)
    func getMonthName(_ date: Date?) -> String
    func getDayWeekName(_ date: String) -> String?
    
}
