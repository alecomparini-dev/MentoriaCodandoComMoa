//  Created by Alessandro Comparini on 14/10/23.
//

import Foundation

import HomeUseCaseGateway
import NetworkSDKMain
import NetworkInterfaces

public class HomeNetwork {
    
    public init() {}
    
}


//  MARK: - EXTENSION - HTTPGet
extension HomeNetwork: HTTPGet {
    public func get(url: URL, headers: [String : String]?, queryParameters: [String : String]?) async throws -> Data? {
           
        let endpoint = EndpointDTO(url: url, headers: headers, queryParameters: queryParameters)
        
        let network = NetworkSDK(endpoint: endpoint)
        
        return try await network.get()
        
    }
}


//  MARK: - EXTENSION - HTTPGet
extension HomeNetwork: HTTPPost {
    
    public func post(url: URL, headers: [String : String]?, queryParameters: [String : String]?, bodyJsonData bodyJson: Data?) async throws -> Data? {
        
        let endpoint = EndpointDTO(url: url, headers: headers, queryParameters: queryParameters)
        
        let network = NetworkSDK(endpoint: endpoint)
                
        return try await network.post(bodyJson: bodyJson)
    }
    
    
}


