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
        
        let data = try await httpPost.post(
            url: url,
            headers: headers,
            queryParameters: queryParameters,
            bodyJson: createProfileData)
            
        
        guard let data else {return nil}
        
        let profileCodable: CreateProfileCodable = try JSONDecoder().decode(CreateProfileCodable.self, from: data)
        
        let profileUseCaseDTO: ProfileUseCaseDTO = profileCodable.mapperToProfileUseCaseDTO()
                
        return profileUseCaseDTO
    }
    
    
    
    
}
