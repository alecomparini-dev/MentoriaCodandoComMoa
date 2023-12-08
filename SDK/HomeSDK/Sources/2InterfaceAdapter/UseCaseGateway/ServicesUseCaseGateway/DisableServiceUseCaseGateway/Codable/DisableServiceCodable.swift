//  Created by Alessandro Comparini on 27/10/23.
//

import Foundation


public struct DisableServiceCodable: Codable {
    public var result: [DisableServiceResultCodable]?
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

    public init(result: [DisableServiceResultCodable]? = nil, resultJSON: String? = nil, isSucess: Bool? = nil, message: String? = nil, stackTrace: String? = nil) {
        self.result = result
        self.resultJSON = resultJSON
        self.isSucess = isSucess
        self.message = message
        self.stackTrace = stackTrace
    }
}



