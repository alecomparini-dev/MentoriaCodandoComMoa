//  Created by Alessandro Comparini on 23/10/23.
//

import Foundation
import HomeUseCases


public class RemoteListServicesUseCaseGatewayImpl: ListServicesUseCaseGateway {
    
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
    
    public func list(_ userIDAuth: String) async throws -> [ServiceDTO]? {
        var query: [String: String] = self.queryParameters
        
        query.updateValue(userIDAuth, forKey: "uIdFirebase")
        
        let data = try await httpGet.get(
            url: url,
            headers: headers,
            queryParameters: query)
        
        guard let data else {return nil}
        
        let servicesCodable: ServicesCodable = try JSONDecoder().decode(ServicesCodable.self, from: data)
                
        let servicesMapper = servicesCodable.mapperToServiceDTO()
        
        return servicesMapper
        
    }
    
    
}
