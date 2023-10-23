//  Created by Alessandro Comparini on 14/10/23.
//

import Foundation
import ProfileUseCases
import ValidatorSDK

public protocol ProfileRegistrationStep2PresenterOutput: AnyObject {
    func searchCEP(success: CEPDTO?, error: String?)
    func validations(validationsError: String?, fieldsRequired: [ProfileRegistrationStep2PresenterImpl.FieldsRequired])
    func createProfile(success: ProfilePresenterDTO?, error: String?)
}

public class ProfileRegistrationStep2PresenterImpl: ProfileRegistrationStep2Presenter {
    public weak var outputDelegate: ProfileRegistrationStep2PresenterOutput?
    
    public enum FieldsRequired {
        case cep
        case street
        case number
        case neighborhood
        case city
        case state
    }
    
    private let createProfile: CreateProfileUseCase
    private let searchCEPUseCase: SearchCEPUseCase
    private let masks: [TypeMasks: Masks]
    
    public init(createProfile: CreateProfileUseCase, searchCEPUseCase: SearchCEPUseCase, masks: [TypeMasks: Masks]) {
        self.createProfile = createProfile
        self.searchCEPUseCase = searchCEPUseCase
        self.masks = masks
    }
    
    public func searchCep(_ cep: String) {
        Task {
            do {
                let cepDTO = try await searchCEPUseCase.get(cep)
                
                let cep = CEPDTO(CEP: cepDTO?.CEP,
                                 street: cepDTO?.street,
                                 neighborhood: cepDTO?.neighborhood,
                                 city: cepDTO?.city,
                                 stateShortname: cepDTO?.stateShortname)
                
                if cep.city == nil || (cep.city ?? "") == "" {
                    DispatchQueue.main.async { [weak self] in
                        self?.outputDelegate?.searchCEP(success: nil, error: "CEP não Localizado")
                    }
                    return
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.outputDelegate?.searchCEP(
                        success: cep,
                        error: nil
                    )
                }
                
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.outputDelegate?.searchCEP(success: nil, error: "CEP inválido ou não localizado")
                }
                
            }
        }
    }

    public func createProfile(_ profilePresenterDTO: ProfilePresenterDTO) {
        if !validations(profilePresenterDTO) {
            return
        }
        
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
                        dateOfBirth: configDateOfBirth(profilePresenterDTO.dateOfBirth),
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
                    self?.outputDelegate?.createProfile(success: profilePresenter, error: nil)
                }

            } catch let error {
                DispatchQueue.main.sync { [weak self] in
                    self?.outputDelegate?.createProfile(success: nil, error: error.localizedDescription)
                }
            }
        }
        
    }
    
    public func setCEPMaskWithRange(_ range: NSRange, _ string: String) -> String? {
        if let cepMask = getMask(.CEPMask) {
            return cepMask.formatStringWithRange(range: range, string: string)
        }
        return nil
    }
    
    private func removeMask(typeMask: TypeMasks,_ text: String?) -> String? {
        guard let text else {return nil}
        let mask = getMask(typeMask)
        return mask?.cleanText(text)
    }
    
    private func configDateOfBirth(_ date: String?) -> String? {
        guard let date else {return date}
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        if let date = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    
//  MARK: - PRIVATE AREA
    private func validations(_ profilePresenterDTO: ProfilePresenterDTO) -> Bool {
        var failsMessage: String?

        let fieldsRequired = isValidFieldsRequired(profilePresenterDTO)

        if let failMsg = isValidAddress(profilePresenterDTO.address?.cep ?? "", fieldsRequired) {
            failsMessage = "\n" + failMsg
        }

        if failsMessage != nil || !fieldsRequired.isEmpty {
            outputDelegate?.validations(validationsError: failsMessage, fieldsRequired: fieldsRequired)
            return false
        }

        return true
    }
        
    private func isValidFieldsRequired(_ profilePresenterDTO: ProfilePresenterDTO) -> [FieldsRequired] {
        var fieldsRequired: [FieldsRequired] = []
        
        if profilePresenterDTO.address?.cep?.isEmpty ?? true {
            fieldsRequired.append(.cep)
        }
        
        if profilePresenterDTO.address?.street?.isEmpty ?? true {
            fieldsRequired.append(.street)
        }
        
        if profilePresenterDTO.address?.number?.isEmpty ?? true {
            fieldsRequired.append(.number)
        }

        if profilePresenterDTO.address?.neighborhood?.isEmpty ?? true {
            fieldsRequired.append(.neighborhood)
        }
        
        if profilePresenterDTO.address?.city?.isEmpty ?? true {
            fieldsRequired.append(.city)
        }
        
        if profilePresenterDTO.address?.state?.isEmpty ?? true {
            fieldsRequired.append(.state)
        }

        return fieldsRequired
    }
    
    private func isValidAddress(_ cep: String, _ fieldsRequired: [FieldsRequired]) -> String? {
        
        if let failMsg = isValidCEP(cep) {
            return failMsg
        }
        
        if fieldsRequired.contains(where: { $0 == .street}) {
            return "Endereço obrigatório.\nFavor pesquisar CEP"
        }
        return nil
    }

    
    private func isValidCEP(_ cep: String) -> String? {
        if cep.isEmpty {return nil}
        let cellPhone = cep.replacingOccurrences(of: "-", with: "")
        
        if cellPhone.count != 8 {
            return "CEP inválido"
        }
        return nil
    }

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
