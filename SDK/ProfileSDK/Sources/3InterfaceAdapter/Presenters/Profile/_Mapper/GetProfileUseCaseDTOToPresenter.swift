//  Created by Alessandro Comparini on 19/10/23.
//

import Foundation

import ProfileUseCases

public struct GetProfileUseCaseDTOToPresenter {
    
    static func mapper(getProfileUseCase: GetProfileUseCaseDTO.Output?) -> ProfilePresenterDTO {
        return ProfilePresenterDTO(
            userIDAuth: getProfileUseCase?.userIDAuth,
            userIDProfile: getProfileUseCase?.userIDProfile,
            imageProfile: getProfileUseCase?.imageProfile,
            name: getProfileUseCase?.name,
            cpf: getProfileUseCase?.cpf,
            dateOfBirth: getProfileUseCase?.dateOfBirth,
            cellPhoneNumber: getProfileUseCase?.cellPhoneNumber,
            fieldOfWork: getProfileUseCase?.fieldOfWork,
            address: ProfileAddressPresenterDTO(
                cep: getProfileUseCase?.cep,
                street: getProfileUseCase?.street,
                number: getProfileUseCase?.number,
                neighborhood: getProfileUseCase?.neighborhood,
                city: getProfileUseCase?.city,
                state: getProfileUseCase?.state))
    }
}
