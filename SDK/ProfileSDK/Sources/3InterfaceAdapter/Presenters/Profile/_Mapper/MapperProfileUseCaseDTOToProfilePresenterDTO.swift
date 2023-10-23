//  Created by Alessandro Comparini on 19/10/23.
//

import Foundation

import ProfileUseCases


public struct MappersProfilePresenter {
    
    static public var maskCleanText: ((_ text: String) -> String)?
    
    static public func mapperTo(profileUseCaseDTO: ProfileUseCaseDTO?) -> ProfilePresenterDTO{
        return ProfilePresenterDTO(
            userIDAuth: profileUseCaseDTO?.userIDAuth,
            userIDProfile: profileUseCaseDTO?.userID,
            imageProfile: profileUseCaseDTO?.image,
            name: profileUseCaseDTO?.name,
            cpf: profileUseCaseDTO?.cpf,
            dateOfBirth: profileUseCaseDTO?.dateOfBirth,
            cellPhoneNumber: profileUseCaseDTO?.cellPhone,
            fieldOfWork: profileUseCaseDTO?.fieldOfWork,
            address: ProfileAddressPresenterDTO(
                cep: profileUseCaseDTO?.profileAddress?.cep,
                street: profileUseCaseDTO?.profileAddress?.street,
                number: profileUseCaseDTO?.profileAddress?.number,
                neighborhood: profileUseCaseDTO?.profileAddress?.neighborhood,
                city: profileUseCaseDTO?.profileAddress?.city,
                state: profileUseCaseDTO?.profileAddress?.state))
    }
    
    static public func mapperTo(profilePresenterDTO: ProfilePresenterDTO?) -> ProfileUseCaseDTO {
        
        return ProfileUseCaseDTO()
    }
    
    
    
    
}

public struct MapperProfileUseCaseDTOToProfilePresenterDTO {
    
    static func mapper(profileUseCaseDTO: ProfileUseCaseDTO?) -> ProfilePresenterDTO {
        return ProfilePresenterDTO(
            userIDAuth: profileUseCaseDTO?.userIDAuth,
            userIDProfile: profileUseCaseDTO?.userID,
            imageProfile: profileUseCaseDTO?.image,
            name: profileUseCaseDTO?.name,
            cpf: profileUseCaseDTO?.cpf,
            dateOfBirth: profileUseCaseDTO?.dateOfBirth,
            cellPhoneNumber: profileUseCaseDTO?.cellPhone,
            fieldOfWork: profileUseCaseDTO?.fieldOfWork,
            address: ProfileAddressPresenterDTO(
                cep: profileUseCaseDTO?.profileAddress?.cep,
                street: profileUseCaseDTO?.profileAddress?.street,
                number: profileUseCaseDTO?.profileAddress?.number,
                neighborhood: profileUseCaseDTO?.profileAddress?.neighborhood,
                city: profileUseCaseDTO?.profileAddress?.city,
                state: profileUseCaseDTO?.profileAddress?.state))
    }
}

