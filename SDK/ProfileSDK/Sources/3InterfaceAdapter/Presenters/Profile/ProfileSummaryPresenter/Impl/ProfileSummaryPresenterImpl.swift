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
    private let masks: [TypeMasks: Masks]
    
    public init(getUserAuthUseCase: GetUserAuthenticatedUseCase, getProfileUseCase: GetProfileUseCase, masks: [TypeMasks : Masks]) {
        self.getUserAuthUseCase = getUserAuthUseCase
        self.getProfileUseCase = getProfileUseCase
        self.masks = masks
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
                let getProfileUseCaseDTO: ProfileUseCaseDTO? = try await getProfileUseCase.getProfile(userIDAuth)
                
                var profilePresenter: ProfilePresenterDTO = GetProfileUseCaseDTOToPresenter.mapper(profileUseCaseDTO: getProfileUseCaseDTO)
                
                let cellPhoneMask = masks[TypeMasks.cellPhoneMask]
                profilePresenter.cellPhoneNumber = cellPhoneMask?.formatString(profilePresenter.cellPhoneNumber)
                
                let CPFMask = masks[TypeMasks.CPFMask]
                profilePresenter.cpf = CPFMask?.formatString(profilePresenter.cpf)
                
                profilePresenter.dateOfBirth = configDateOfBirth(profilePresenter.dateOfBirth)
                
                let CEPMask = masks[TypeMasks.CEPMask]
                let cep = CEPMask?.formatString(profilePresenter.address?.cep)
                profilePresenter.address?.cep = cep
                
                DispatchQueue.main.sync { [weak self] in
                    self?.outputDelegate?.getUserProfile(success: profilePresenter, error: nil)
                }
                
            } catch let error {
                DispatchQueue.main.sync { [weak self] in
                    self?.outputDelegate?.getUserProfile(success: nil, error: error.localizedDescription)
                }
            }
        }
        
    }
    
    public func saveProfileImageData(_ userIDAuth: String?, _ imageData: Data) {
        guard let userIDAuth else {return}
        if let filename = getDocumentsDirectory()?.appendingPathComponent("\(userIDAuth).jpg") {
            try? imageData.write(to: filename)
        }
    }
    
    public func getProfileImageData(_ userIDAuth: String?) -> Data? {
        guard let userIDAuth else {return nil}
        if let fileURL = getDocumentsDirectory()?.appendingPathComponent("\(userIDAuth).jpg") {
            return try? Data(contentsOf: fileURL)
        }
        return nil
    }
    
    
//  MARK: - PRIVATE AREA
    private func configDateOfBirth(_ date: String?) -> String? {
        guard let date else {return nil}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        if let date = dateFormatter.date(from: date) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "dd/MM/yyyy"
            return outputDateFormatter.string(from: date)
        }
        
        return nil
    }
    
    private func getDocumentsDirectory() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
}
