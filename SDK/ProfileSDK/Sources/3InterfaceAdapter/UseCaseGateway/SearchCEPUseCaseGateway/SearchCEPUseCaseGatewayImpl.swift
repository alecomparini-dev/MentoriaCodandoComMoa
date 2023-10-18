//  Created by Alessandro Comparini on 14/10/23.
//

import Foundation

import ProfileUseCases

public class SearchCEPUseCaseGatewayImpl: SearchCEPUseCaseGateway {
    
    private let httpGet: HTTPGet
    private let url: URL
    private let headers: [String: String]
    private let queryParameters: [String: String]
    
    public init(httpGet: HTTPGet, url: URL, headers: [String : String], queryParameters: [String : String]) {
        self.httpGet = httpGet
        self.url = url
        self.headers = headers
        self.queryParameters = queryParameters
    }
    
    public func get(_ cep: String) async throws -> SearchCEPUseCaseDTO.Output? {
        
        guard let urlRequest = URL(string: url.description.replacingOccurrences(of: "id_cep", with: "\(cep)") ) else {return nil}
        
        let data = try await httpGet.get(url: urlRequest, headers: headers, queryParameters: queryParameters)
        
        guard let data else {return nil}
        
//        let cepCodable: CEPCodable = try JSONDecoder().decode(CEPCodable.self, from: data)
        let cepCodable: ViaCEPCodable = try JSONDecoder().decode(ViaCEPCodable.self, from: data)
        
        return cepCodable.mapperToDTO()
    }
    
    
}
