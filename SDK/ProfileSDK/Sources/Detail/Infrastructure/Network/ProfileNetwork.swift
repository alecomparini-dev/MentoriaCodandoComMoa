//  Created by Alessandro Comparini on 14/10/23.
//

import Foundation

import ProfileUseCaseGateway

import NetworkSDKMain
import NetworkInterfaces

public class ProfileNetwork {
    
    public init() {}
    
}


//  MARK: - EXTENSION - HTTPGet
extension ProfileNetwork: HTTPGet {
    public func get(url: URL, headers: [String : String]?, queryParameters: [String : String]?) async throws -> Data? {
           
        let endpoint = EndpointDTO(url: url, headers: headers, queryParameters: queryParameters)
        
        let network = NetworkSDK(endpoint: endpoint)
        
        return try await network.get()
        
    }
}


//  MARK: - EXTENSION - HTTPGet
extension ProfileNetwork: HTTPPost {
    
    public func post(url: URL, headers: [String : String]?, queryParameters: [String : String]?, bodyJson: Data?) async throws -> Data? {
        
        let endpoint = EndpointDTO(url: url, headers: headers, queryParameters: queryParameters)
        
        let network = NetworkSDK(endpoint: endpoint)
                
        return try await network.post(bodyJson: bodyJson)
    }
    
    
}


