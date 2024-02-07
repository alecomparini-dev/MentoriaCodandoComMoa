//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation

public protocol ProfileSummaryPresenter {
    var outputDelegate: ProfileSummaryPresenterOutput? { get set }
    
    func logout()
    
    func fetchUserProfile()
    
    func getProfilePresenter() -> ProfilePresenterDTO?
    
    func clearProfilePresenter()
    
    func saveProfileImageData(_ profilePresenterDTO: ProfilePresenterDTO?)
    
    func getProfileImageData(_ profilePresenterDTO: ProfilePresenterDTO?) -> Data?
    
}
