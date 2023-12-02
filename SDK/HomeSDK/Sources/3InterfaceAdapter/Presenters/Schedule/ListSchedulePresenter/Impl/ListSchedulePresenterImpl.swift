//  Created by Alessandro Comparini on 01/12/23.
//

import Foundation

public class ListSchedulePresenterImpl: ListSchedulePresenter {
    
    public init() {}
    
    public enum ItemsDock: Int {
        case all = 0
        case today = 1
        case sevenDay = 2
        case currentMonth = 3
        case quatro = 4
        case cinco = 5
    }
    
    
    
    
    public func sizeItemsDock() -> [ItemsDock : CGSize] {
        return [
            ItemsDock.all : CGSize(width: 135, height: 40),
            ItemsDock.today : CGSize(width: 100, height: 40),
            ItemsDock.sevenDay : CGSize(width: 100, height: 40),
            ItemsDock.currentMonth : CGSize(width: 150, height: 40),
            ItemsDock.quatro : CGSize(width: 150, height: 40),
            ItemsDock.cinco : CGSize(width: 150, height: 40),
        ]
    }
    
    public func labelItemsDock() -> [ItemsDock : String] {
        return [
            ItemsDock.all : "Ver todos",
            ItemsDock.today : "Hoje",
            ItemsDock.sevenDay : "7 dias",
            ItemsDock.currentMonth : "Mês atual",
            ItemsDock.quatro : "Mês atual",
            ItemsDock.cinco : "Mês atual",
        ]
    }
    
    public func iconItemsDock() -> [ItemsDock: String] {
        return [
            ItemsDock.all : "rectangle.stack",
            ItemsDock.today : "target",
            ItemsDock.sevenDay : "calendar.circle",
            ItemsDock.currentMonth : "calendar.badge.clock"
        ]
    }
                            
    
}
