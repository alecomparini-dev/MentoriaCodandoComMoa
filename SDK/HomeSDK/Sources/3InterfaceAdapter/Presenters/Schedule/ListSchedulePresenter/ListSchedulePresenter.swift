//  Created by Alessandro Comparini on 01/12/23.
//

import Foundation

public protocol ListSchedulePresenter {
    
    func sizeItemsDock() -> [ListSchedulePresenterImpl.ItemsDock: CGSize]
    func labelItemsDock() -> [ListSchedulePresenterImpl.ItemsDock: String]
    func iconItemsDock() -> [ListSchedulePresenterImpl.ItemsDock: String]
}
