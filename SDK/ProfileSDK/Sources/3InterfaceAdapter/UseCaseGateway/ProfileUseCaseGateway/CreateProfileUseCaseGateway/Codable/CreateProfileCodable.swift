//  Created by Alessandro Comparini on 20/10/23.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let createProfile = try? JSONDecoder().decode(CreateProfile.self, from: jsonData)

import Foundation

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

