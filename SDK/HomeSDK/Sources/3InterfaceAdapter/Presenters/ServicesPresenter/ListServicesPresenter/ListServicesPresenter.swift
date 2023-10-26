//  Created by Alessandro Comparini on 26/10/23.
//

import Foundation

public protocol ListServicesPresenter {
    var outputDelegate: ListServicesPresenterOutput? { get set }
    
    func fetchCurrencies(_ userIDAuth: String)
    
    func numberOfRowsInSection() -> Int?
    
    func getServices() -> [ServicePresenterDTO]?
    
    func getServiceBy(index: Int) -> ServicePresenterDTO?
    
    func filterServices(_ text: String)
    
}
