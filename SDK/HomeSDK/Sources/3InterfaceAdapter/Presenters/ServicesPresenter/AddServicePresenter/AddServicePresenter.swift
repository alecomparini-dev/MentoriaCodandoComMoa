//  Created by Alessandro Comparini on 28/10/23.
//

import Foundation

import HomeUseCases

public protocol AddServicePresenter {
    var outputDelegate: AddServicePresenterOutput? { get set }
    
    func addService(_ servicePresenterDTO: ServicePresenterDTO)
    
    
}
