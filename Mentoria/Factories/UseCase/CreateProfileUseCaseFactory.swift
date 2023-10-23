//  Created by Alessandro Comparini on 23/10/23.
//

import Foundation
import ProfileUseCases
import ProfileUseCaseGateway

public class CreateProfileUseCaseFactory {
    
    static func make() -> CreateProfileUseCase {
        
        let httpPost: HTTPPost = Network()
        
        let createProfileURL = makeCreateProfileURL()
        
        let createProfileUseCaseGateway = RemoteCreateProfileUseCaseGatewayImpl(
            httpPost: httpPost,
            url: createProfileURL,
            headers: [:],
            queryParameters: [:])
        
        return CreateProfileUseCaseImpl(createProfileUseCaseGateway: createProfileUseCaseGateway)
        
    }
    
    static private func makeCreateProfileURL() -> URL {
        let baseURL = Environment.variable(.apiBaseUrl)
        let path = K.pathCreateProfile
        return URL(string: "\(baseURL)\(path)")!
    }
    
}
