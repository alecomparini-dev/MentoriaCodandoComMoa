//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation

public protocol ProfileSummaryPresenter {
    var outputDelegate: ProfileSummaryPresenterOutput? { get set }
    
    func getUserAuthenticated()
    
    func logout()
    
    func getProfile(_ userIDAuth: String)
    
    func saveProfileImageData(_ profilePresenterDTO: ProfilePresenterDTO?)
    
    func getProfileImageData(_ profilePresenterDTO: ProfilePresenterDTO?) -> Data?
    
}
