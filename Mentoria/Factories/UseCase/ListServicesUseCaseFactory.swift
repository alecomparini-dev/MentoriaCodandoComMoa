//  Created by Alessandro Comparini on 07/12/23.
//

import Foundation

import HomeUseCases
import HomeUseCaseGateway
import HomeNetwork

public class ListServicesUseCaseFactory {
    
    static func make() -> ListServicesUseCase {
        
        let httpGet = HomeNetwork()
        
        let url = makeURL()
        
        let listServicesUseCaseGateway = RemoteListServicesUseCaseGatewayImpl(httpGet: httpGet ,
                                                                              url: url, headers: [:],
                                                                              queryParameters: [:])
        
        return ListServicesUseCaseImpl(listServicesGateway: listServicesUseCaseGateway)
    }
    
    
//  MARK: - PRIVATE AREA
    
    static private func makeURL() -> URL {
        let baseURL = Environment.variable(.apiBaseUrl)
        let path = K.pathListServices
        return URL(string: "\(baseURL)\(path)")!
    }
    
}
