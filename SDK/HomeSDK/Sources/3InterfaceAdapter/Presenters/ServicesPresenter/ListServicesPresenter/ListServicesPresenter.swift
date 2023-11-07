//  Created by Alessandro Comparini on 26/10/23.
//

import Foundation

public protocol ListServicesPresenter {
    var outputDelegate: ListServicesPresenterOutput? { get set }
    
    func numberOfRowsInSection() -> Int
    
    func heightForRowAt() -> CGFloat
    
    func fetchCurrencies(_ userIDAuth: String)
    
    func getServices() -> [ServicePresenterDTO]?
    
    func clearServices()
    
    func getServiceBy(index: Int) -> ServicePresenterDTO?
    
    func filterServices(_ text: String)
    
}
