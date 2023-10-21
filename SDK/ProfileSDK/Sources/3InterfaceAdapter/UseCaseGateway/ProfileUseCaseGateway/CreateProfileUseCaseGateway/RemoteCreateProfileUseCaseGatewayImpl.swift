//  Created by Alessandro Comparini on 20/10/23.
//

import Foundation

import ProfileUseCases

public class RemoteCreateProfileUseCaseGatewayImpl: CreateProfileUseCaseGateway {
    
    private let httpPost: HTTPPost
    private let url: URL
    private let headers: [String: String]
    private let queryParameters: [String: String]

    public init(httpPost: HTTPPost,
                url: URL,
                headers: [String : String],
                queryParameters: [String : String]) {
        self.httpPost = httpPost
        self.url = url
        self.headers = headers
        self.queryParameters = queryParameters
    }
    
    public func create(_ profile: ProfileUseCaseDTO) async throws -> ProfileUseCaseDTO? {
        
        let createProfileCodable = ProfileDTOToCreateProfileCodableMapper.mapper(profileDTO: profile).result
        
        let createProfileData = try JSONEncoder().encode(createProfileCodable)
        
        let bodyJson = try JSONSerialization.jsonObject(with: createProfileData, options: .fragmentsAllowed) as? [String: Any]
        
        let data = try await httpPost.post(
            url: url,
            headers: headers,
            queryParameters: queryParameters,
            bodyJson: bodyJson ?? [:])
            
        
        guard let data else {return nil}
        
        let profile: CreateProfileCodable = try JSONDecoder().decode(CreateProfileCodable.self, from: data)
        
//        var profileMapper = createProfileCodable.mapperToProfileUseCaseModel()
                
        return nil
    }
    
    
    
    
}
