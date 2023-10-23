//  Created by Alessandro Comparini on 14/10/23.
//

import Foundation

import ProfileUI
import ProfilePresenters
import ProfileUseCases
import ProfileUseCaseGateway

class ProfileRegistrationStep2Factory {
    
    static func make() -> ProfileRegistrationStep2ViewController {
        
        let httpGet: HTTPGet = Network()
        
        let url = URL(string: Environment.variable(Environment.Variables.apiBaseCEP))!
        
        let searchUseCaseGateway = RemoteSearchCEPUseCaseGatewayImpl(httpGet: httpGet,
                                                               url: url ,
                                                               headers: [:],
                                                               queryParameters: [:])
        
        let searchUseCase = SearchCEPUseCaseImpl(searchCEPGateway: searchUseCaseGateway)
        
        
        let httpPost: HTTPPost = Network()
        
        let createProfileURL = makeCreateProfileURL()
        
        let createProfileUseCaseGateway = RemoteCreateProfileUseCaseGatewayImpl(
            httpPost: httpPost,
            url: createProfileURL,
            headers: [:],
            queryParameters: [:])
        
        let createProfileUseCase = CreateProfileUseCaseImpl(createProfileUseCaseGateway: createProfileUseCaseGateway)
        
        let profileRegistrationStep2Presenter = ProfileRegistrationStep2PresenterImpl(createProfile: createProfileUseCase, searchCEPUseCase: searchUseCase, masks: makeMasks())
        
        return ProfileRegistrationStep2ViewController(profileStep2Presenter: profileRegistrationStep2Presenter)
        
    }
    
    static private func makeCreateProfileURL() -> URL {
        let baseURL = Environment.variable(.apiBaseUrl)
        let path = K.pathCreateProfile
        return URL(string: "\(baseURL)\(path)")!
    }
    
    static private func makeMasks() -> [TypeMasks: Masks] {
        var masks: [TypeMasks: Masks] = [:]
        masks.updateValue(CellPhoneMask(), forKey: TypeMasks.cellPhoneMask)
        masks.updateValue(CPFMask(), forKey: TypeMasks.CPFMask)
        masks.updateValue(DateMask(), forKey: TypeMasks.dateMask)
        masks.updateValue(CEPMask(), forKey: TypeMasks.CEPMask)
        return masks
    }
    
}
