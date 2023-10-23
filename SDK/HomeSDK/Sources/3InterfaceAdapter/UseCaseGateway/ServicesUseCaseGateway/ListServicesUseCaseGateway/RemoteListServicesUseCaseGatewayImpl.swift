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
    
    public func list() async throws {
        
    }
    
    
}
