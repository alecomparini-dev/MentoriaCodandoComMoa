//  Created by Alessandro Comparini on 08/12/23.
//

import Foundation

import HomeUseCases
import HomeDomain

public class RemoteListClientsUseCaseGatewayImpl: ListClientsUseCaseGateway {
    
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
    
    
    public func list(_ userIDAuth: String) async throws -> [ClientModel] {
        var query: [String: String] = self.queryParameters
        
        query.updateValue(userIDAuth, forKey: "uIdFirebase")
        
        let data = try await httpGet.get(
            url: url,
            headers: headers,
            queryParameters: query)
        
        guard let data else {return []}
        
        let clientsCodable: ClientsCodable = try JSONDecoder().decode(ClientsCodable.self, from: data)
                
        return clientsCodable.mapperToClientModel()
    }
    
    
    
}
