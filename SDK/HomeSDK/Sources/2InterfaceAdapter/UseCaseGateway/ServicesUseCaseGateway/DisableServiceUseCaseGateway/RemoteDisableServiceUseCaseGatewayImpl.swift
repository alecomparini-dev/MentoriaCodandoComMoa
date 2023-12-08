//  Created by Alessandro Comparini on 27/10/23.
//

import Foundation

import HomeUseCases


public class RemoteDisableServiceUseCaseGatewayImpl: DisableServiceUseCaseGateway {
    
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
    
    
    public func disable(_ idService: Int, _ userIDAuth: String) async throws -> Bool {
        
        var query: [String: String] = self.queryParameters
        
        query.updateValue(userIDAuth, forKey: "uIdFirebase")
        query.updateValue(idService.description, forKey: "id")
        
        let data = try await httpPost.post(
            url: url,
            headers: headers,
            queryParameters: query,
            bodyJsonData: nil)
            
        guard let data else {return false}
        
        let disableServiceCodable: DisableServiceCodable = try JSONDecoder().decode(DisableServiceCodable.self, from: data)
        
        return disableServiceCodable.isSucess ?? false
    }
    
    
}
