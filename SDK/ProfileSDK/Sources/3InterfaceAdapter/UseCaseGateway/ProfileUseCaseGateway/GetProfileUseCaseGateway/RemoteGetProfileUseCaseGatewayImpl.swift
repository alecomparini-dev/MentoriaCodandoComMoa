//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation

import ProfileUseCases

public class RemoteGetProfileUseCaseGatewayImpl: GetProfileUseCaseGateway {
    
    private let httpGet: HTTPGet
    private let url: URL
    private let headers: [String: String]
    private let queryParameters: [String: String]

    public init(httpGet: HTTPGet, 
                url: URL,
                headers: [String : String],
                queryParameters: [String : String]) {
        self.httpGet = httpGet
        self.url = url
        self.headers = headers
        self.queryParameters = queryParameters
    }
    
    
    public func getProfile(_ userIDAuth: String) async throws -> ProfileUseCaseDTO? {
        var query: [String: String] = self.queryParameters
        
        query.updateValue(userIDAuth, forKey: "uIdFirebase")
        
        let data = try await httpGet.get(
            url: url,
            headers: headers,
            queryParameters: query)
        
        guard let data else {return nil}
        
        let profileCodable: ProfileCodable = try JSONDecoder().decode(ProfileCodable.self, from: data)
                
        var profileMapper = profileCodable.mapperToProfileUseCaseDTO()
        
        profileMapper.userIDAuth = userIDAuth
        
        return profileMapper
    }
    
    
}
