//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation
import ProfileUseCases


public protocol ProfileSummaryPresenterOutput: AnyObject {
    func getUserAuthenticated(success: ProfilePresenterDTO?, error: String?)
    func getUserProfile(success: ProfilePresenterDTO?, error: String?)
}


public class ProfileSummaryPresenterImpl: ProfileSummaryPresenter {
    public weak var outputDelegate: ProfileSummaryPresenterOutput?
    
    private let getUserAuthUseCase: GetUserAuthenticatedUseCase
    
    public init(getUserAuthUseCase: GetUserAuthenticatedUseCase) {
        self.getUserAuthUseCase = getUserAuthUseCase
    }
    
    public func getUserAuthenticated() {
        Task {
            do {
                let userAuth: UserAuthenticatedUseCaseDTO.Output =  try await getUserAuthUseCase.getUser()
                DispatchQueue.main.async { [weak self] in
                    self?.outputDelegate?.getUserAuthenticated(success: ProfilePresenterDTO(userIDAuth: userAuth.userIDAuth), error: nil)
                }
            } catch let error {
                DispatchQueue.main.async { [weak self] in
                    self?.outputDelegate?.getUserAuthenticated(success: nil, error: error.localizedDescription)
                }
            }
        }
    }
    
    public func getProfile(_ userIDAuth: String) {
        
    }

    
}
