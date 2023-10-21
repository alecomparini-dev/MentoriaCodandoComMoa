//  Created by Alessandro Comparini on 20/10/23.
//

import Foundation

import ProfileUseCases


public struct ProfileDTOToCreateProfileCodableMapper {
    
    static public func mapper(profileDTO: ProfileUseCaseDTO) -> CreateProfileCodable {
        return CreateProfileCodable(
            result: ResultCodable(
                name: profileDTO.name,
                image: profileDTO.image,
                phone: profileDTO.cellPhone,
                cpf: profileDTO.cpf,
                typeOfActivity: profileDTO.fieldOfWork,
                birthdate: profileDTO.dateOfBirth,
                cep: profileDTO.profileAddress?.cep,
                street: profileDTO.profileAddress?.street,
                number: profileDTO.profileAddress?.number,
                district: profileDTO.profileAddress?.neighborhood,
                city: profileDTO.profileAddress?.city,
                state: profileDTO.profileAddress?.state,
                id: profileDTO.userID,
                uid: profileDTO.userIDAuth,
                uidFirebase: profileDTO.userIDAuth
            )
        )
    }
    
}
