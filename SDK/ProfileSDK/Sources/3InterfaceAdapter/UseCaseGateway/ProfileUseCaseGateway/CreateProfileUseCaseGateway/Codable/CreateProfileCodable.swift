//  Created by Alessandro Comparini on 20/10/23.
//

import Foundation

import ProfileUseCases

// MARK: - CreateProfile
public struct CreateProfileCodable: Codable {
    public var result: ResultCodable?
    public var resultJSON: String?
    public var isSucess: Bool?
    public var message: String?
    public var exception: String?
    public var stackTrace: String?

    enum CodingKeys: String, CodingKey {
        case result = "Result"
        case resultJSON = "ResultJson"
        case isSucess = "IsSucess"
        case message = "Message"
        case exception = "Exception"
        case stackTrace = "StackTrace"
    }
    
    public init(result: ResultCodable? = nil,
                resultJSON: String? = nil,
                isSucess: Bool? = nil,
                message: String? = nil,
                exception: String? = nil,
                stackTrace: String? = nil) {
        self.result = result
        self.resultJSON = resultJSON
        self.isSucess = isSucess
        self.message = message
        self.exception = exception
        self.stackTrace = stackTrace
    }
}


//  MARK: - EXTENSION - CreateProfileCodable

extension CreateProfileCodable {
    func mapperToProfileUseCaseDTO() -> ProfileUseCaseDTO {
        return ProfileUseCaseDTO(
            userIDAuth: self.result?.uidFirebase,
            userID: self.result?.id,
            name: self.result?.name,
            image: self.result?.image,
            cpf: self.result?.cpf,
            phone: self.result?.phone,
            fieldOfWork: self.result?.typeOfActivity,
            dateOfBirth: self.result?.birthdate,
            profileAddress: ProfileAddressUseCaseDTO(
                cep: self.result?.cep,
                street: self.result?.street,
                number: self.result?.number,
                neighborhood: self.result?.district,
                city: self.result?.city,
                state: self.result?.state
            )
        )
    }
    
}
