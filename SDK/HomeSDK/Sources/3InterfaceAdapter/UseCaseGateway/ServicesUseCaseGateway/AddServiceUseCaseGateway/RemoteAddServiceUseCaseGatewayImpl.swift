//  Created by Alessandro Comparini on 28/10/23.
//

import Foundation

import HomeUseCases

public class RemoteAddServiceUseCaseGatewayImpl: AddServiceUseCaseGateway {
    
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
    
    public func add(_ serviceUseCaseDTO: HomeUseCases.ServiceUseCaseDTO) async throws -> ServiceUseCaseDTO? {
        
        let addServiceCodableMapper = MapperServiceUseCaseDTO.mapperToAddServiceResultCodable(serviceUseCaseDTO)
        
        let addServiceData = try JSONEncoder().encode(addServiceCodableMapper)
        
        let bodyJson = try JSONSerialization.jsonObject(with: addServiceData, options: []) as? [String: Any]
        
        let data = try await httpPost.post(
            url: url,
            headers: headers,
            queryParameters: queryParameters,
            bodyJson: bodyJson ?? [:])
            
        guard let data else {return nil}
        
        let addServiceCodable: AddServiceCodable = try JSONDecoder().decode(AddServiceCodable.self, from: data)
        
        let serviceUseCaseDTO: ServiceUseCaseDTO = addServiceCodable.mapperToServiceUseCaseDTO()
                
        return serviceUseCaseDTO
        
    }
    
    
    
    
}
