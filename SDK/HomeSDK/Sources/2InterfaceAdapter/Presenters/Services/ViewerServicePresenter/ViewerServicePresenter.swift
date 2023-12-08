//  Created by Alessandro Comparini on 27/10/23.
//

import Foundation

public protocol ViewerServicePresenter {
    var outputDelegate: ViewerServicePresenterOutput? { get set }
    
    func disableService(_ idService: Int, _ userIDAuth: String)
    
}
