//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation

import ProfileUseCases

public protocol ProfileSummaryPresenterOutput: AnyObject {
    func getUserAuthenticated(success: ProfilePresenterDTO?, error: String?)
    func getUserProfile(success: ProfilePresenterDTO?, error: String?)
    func saveProfileImage(success: ProfilePresenterDTO?, error: String?)
}


public class ProfileSummaryPresenterImpl: ProfileSummaryPresenter {

    public weak var outputDelegate: ProfileSummaryPresenterOutput?
    
    private let getUserAuthUseCase: GetUserAuthenticatedUseCase
    private let getProfileUseCase: GetProfileUseCase
    private let createProfile: CreateProfileUseCase
    private let masks: [TypeMasks: Masks]
    
    public init(getUserAuthUseCase: GetUserAuthenticatedUseCase, getProfileUseCase: GetProfileUseCase, createProfile: CreateProfileUseCase, masks: [TypeMasks : Masks]) {
        self.getUserAuthUseCase = getUserAuthUseCase
        self.getProfileUseCase = getProfileUseCase
        self.createProfile = createProfile
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
                
                var profilePresenter: ProfilePresenterDTO = MappersProfilePresenter.mapperTo(profileUseCaseDTO: getProfileUseCaseDTO)
                
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

//    TODO: - CODIGO DUPLICADO EXTRAIR
    public func saveProfileImageData(_ profilePresenterDTO: ProfilePresenterDTO?) {
        guard let profilePresenterDTO else {return}
        
        Task {
            do {
                let profileDTO = try await createProfile.create(
                    ProfileUseCaseDTO(
                        userIDAuth: profilePresenterDTO.userIDAuth,
                        userID: profilePresenterDTO.userIDProfile,
                        name: profilePresenterDTO.name,
                        image: profilePresenterDTO.imageProfile,
                        cpf: removeMask(typeMask: .CPFMask, profilePresenterDTO.cpf),
                        phone: removeMask(typeMask: .cellPhoneMask, profilePresenterDTO.cellPhoneNumber),
                        fieldOfWork: profilePresenterDTO.fieldOfWork,
                        dateOfBirth: configDateToSave(profilePresenterDTO.dateOfBirth),
                        profileAddress: ProfileAddressUseCaseDTO(
                            cep: removeMask( typeMask: .CEPMask, profilePresenterDTO.address?.cep),
                            street: profilePresenterDTO.address?.street,
                            number: profilePresenterDTO.address?.number,
                            neighborhood: profilePresenterDTO.address?.neighborhood,
                            city: profilePresenterDTO.address?.city,
                            state: profilePresenterDTO.address?.state)
                    )
                )
                
                var profilePresenter: ProfilePresenterDTO = MapperProfileUseCaseDTOToProfilePresenterDTO.mapper(profileUseCaseDTO: profileDTO)
                let cellPhoneMask = masks[TypeMasks.cellPhoneMask]
                profilePresenter.cellPhoneNumber = cellPhoneMask?.formatString(profilePresenter.cellPhoneNumber)
                
                let CPFMask = masks[TypeMasks.CPFMask]
                profilePresenter.cpf = CPFMask?.formatString(profilePresenter.cpf)
                
                profilePresenter.dateOfBirth = configDateOfBirth(profilePresenter.dateOfBirth)
                
                let CEPMask = masks[TypeMasks.CEPMask]
                let cep = CEPMask?.formatString(profilePresenter.address?.cep)
                profilePresenter.address?.cep = cep
                
                DispatchQueue.main.sync { [weak self] in
                    self?.outputDelegate?.saveProfileImage(success: profilePresenter, error: nil)
                }

            } catch let error {
                DispatchQueue.main.sync { [weak self] in
                    self?.outputDelegate?.saveProfileImage(success: nil, error: error.localizedDescription)
                }
            }
        }
        
    }
    
    public func getProfileImageData(_ profilePresenterDTO: ProfilePresenterDTO?) -> Data? {
        guard let profilePresenterDTO else {return nil}
        if let imageProfile = profilePresenterDTO.imageProfile {
            return Data(base64Encoded: imageProfile, options: .ignoreUnknownCharacters)
        }
        return nil
    }
    


//    public func saveProfileImageData(_ userIDAuth: String?, _ imageData: Data) {
//        guard let userIDAuth else {return}
//        if let filename = getDocumentsDirectory()?.appendingPathComponent("\(userIDAuth).jpg") {
//            try? imageData.write(to: filename)
//        }
//    }
//    
//    public func getProfileImageData(_ userIDAuth: String?) -> Data? {
//        guard let userIDAuth else {return nil}
//        if let fileURL = getDocumentsDirectory()?.appendingPathComponent("\(userIDAuth).jpg") {
//            return try? Data(contentsOf: fileURL)
//        }
//        return nil
//    }
    
    
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
    
    private func configDateToSave(_ date: String?) -> String? {
        guard let date else {return date}
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        if let date = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    private func getDocumentsDirectory() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    //    TODO: - CODIGO DUPLICADO EXTRAIR
    private func removeMask(typeMask: TypeMasks,_ text: String?) -> String? {
        guard let text else {return nil}
        let mask = getMask(typeMask)
        return mask?.cleanText(text)
    }
    
    //    TODO: - CODIGO DUPLICADO EXTRAIR
    private func getMask(_ typeMask: TypeMasks) -> Masks? {
        switch typeMask {
            case .cellPhoneMask:
                return masks[TypeMasks.cellPhoneMask]
            case .CPFMask:
                return masks[TypeMasks.CPFMask]
            case .dateMask:
                return masks[TypeMasks.dateMask]
            case .CEPMask:
                return masks[TypeMasks.CEPMask]
        }
    }
    
}
