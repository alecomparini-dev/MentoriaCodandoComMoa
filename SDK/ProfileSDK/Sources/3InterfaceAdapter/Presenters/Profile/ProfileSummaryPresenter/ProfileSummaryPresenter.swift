//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation

public protocol ProfileSummaryPresenter {
    var outputDelegate: ProfileSummaryPresenterOutput? { get set }
    
    func getUserAuthenticated()
    
    func getProfile(_ userIDAuth: String)
    
    func saveProfileImageData(_ userIDAuth: String?, _ imageData: Data)
    
    func getProfileImageData(_ userIDAuth: String?) -> Data?
    
}
