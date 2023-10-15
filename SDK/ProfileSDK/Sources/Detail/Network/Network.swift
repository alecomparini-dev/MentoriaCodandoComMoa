//  Created by Alessandro Comparini on 14/10/23.
//

import Foundation
import ProfileUseCaseGateway
import NetworkSDKMain
import NetworkInterfaces

public class Network: HTTPGet {
    
    public init() {}
    
    public func get(url: URL, headers: [String : String]?, queryParameters: [String : String]?) async throws -> Data? {
           
        let endpoint = EndpointDTO(url: url, headers: headers, queryParameters: queryParameters)
        
        let network = NetworkSDK(endpoint: endpoint)
        
        return try await network.get()
        
    }
    
}
