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
    private let getProfileUseCase: GetProfileUseCase
    
    public init(getUserAuthUseCase: GetUserAuthenticatedUseCase, getProfileUseCase: GetProfileUseCase) {
        self.getUserAuthUseCase = getUserAuthUseCase
        self.getProfileUseCase = getProfileUseCase
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
        
        Task {
            do {
                let getProfileUseCaseDTO: GetProfileUseCaseDTO.Output? = try await getProfileUseCase.getProfile(userIDAuth)
                
                let profilePresenterMapper = GetProfileUseCaseDTOToPresenter.mapper(getProfileUseCase: getProfileUseCaseDTO)
                
                DispatchQueue.main.sync { [weak self] in
                    self?.outputDelegate?.getUserProfile(success: profilePresenterMapper, error: nil)
                }
                
            } catch let error {
                DispatchQueue.main.sync { [weak self] in
                    self?.outputDelegate?.getUserProfile(success: nil, error: error.localizedDescription)
                }
            }
        }
        
        
        
    }

    
}
