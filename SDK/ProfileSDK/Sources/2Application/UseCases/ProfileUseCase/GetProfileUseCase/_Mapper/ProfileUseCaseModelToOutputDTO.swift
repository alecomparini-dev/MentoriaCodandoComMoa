//  Created by Alessandro Comparini on 19/10/23.
//

import Foundation

public struct ProfileUseCaseModelToOutputDTO {
    
    static func mapper(profileModel: ProfileUseCaseModel?) -> GetProfileUseCaseDTO.Output? {
        guard let profileModel else {return nil }
        return GetProfileUseCaseDTO.Output(
            userIDAuth: profileModel.userIDAuth,
            userIDProfile: profileModel.userID,
            imageProfile: profileModel.image,
            name: profileModel.name,
            cpf: profileModel.cpf,
            dateOfBirth: profileModel.dateOfBirth,
            cellPhoneNumber: profileModel.phone,
            fieldOfWork: profileModel.fieldOfWork,
            cep: profileModel.profileAddress?.cep,
            street: profileModel.profileAddress?.street,
            number: profileModel.profileAddress?.number,
            neighborhood: profileModel.profileAddress?.neighborhood,
            city: profileModel.profileAddress?.city,
            state: profileModel.profileAddress?.state,
            complement: profileModel.profileAddress?.complement)
    }
    
}
