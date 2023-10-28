//  Created by Alessandro Comparini on 27/10/23.
//

import Foundation

import HomeUseCases

public struct AddServiceCodable: Codable {
    public var result: AddServiceResultCodable?
    public var resultJSON: String?
    public var isSucess: Bool?
    public var message: String?
    public var stackTrace: String?

    enum CodingKeys: String, CodingKey {
        case result = "Result"
        case resultJSON = "ResultJson"
        case isSucess = "IsSucess"
        case message = "Message"
        case stackTrace = "StackTrace"
    }

    public init(result: AddServiceResultCodable? = nil, resultJSON: String? = nil, isSucess: Bool? = nil, message: String? = nil, stackTrace: String? = nil) {
        self.result = result
        self.resultJSON = resultJSON
        self.isSucess = isSucess
        self.message = message
        self.stackTrace = stackTrace
    }
}


extension AddServiceCodable {
    
    func mapperToServiceUseCaseDTO() -> ServiceUseCaseDTO {
        return ServiceUseCaseDTO(
            uidFirebase: self.result?.uidFirebase,
            id: self.result?.id,
            name: self.result?.name,
            description: self.result?.description,
            duration: self.result?.duration,
            howMutch: self.result?.howMutch,
            uid: self.result?.uid
        )
    }
    
}
 

