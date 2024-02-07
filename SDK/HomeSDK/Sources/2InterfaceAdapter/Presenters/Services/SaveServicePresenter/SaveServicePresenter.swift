//  Created by Alessandro Comparini on 28/10/23.
//

import Foundation

import HomeUseCases

public protocol SaveServicePresenter {
    var outputDelegate: SaveServicePresenterOutput? { get set }
    
    func heightForRowAt() -> CGFloat
    func numberOfRowsInSection() -> Int
    
    func saveService(_ servicePresenterDTO: ServicePresenterDTO)
    
    func disableService(_ idService: Int, _ userIDAuth: String)
    
    func mustBeHiddenDisableServiceButton(_ servicePresenterDTO: ServicePresenterDTO?) -> Bool
    
    func removeAlphabeticCharacters(from input: String) -> String 
}
