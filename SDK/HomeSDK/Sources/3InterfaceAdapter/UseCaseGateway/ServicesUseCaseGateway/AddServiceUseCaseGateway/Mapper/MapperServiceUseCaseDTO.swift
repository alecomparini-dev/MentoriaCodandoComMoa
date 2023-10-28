//  Created by Alessandro Comparini on 28/10/23.
//

import Foundation

import HomeUseCases

public struct MapperServiceUseCaseDTO {
    
    static public func mapperToAddServiceResultCodable(_ serviceUseCaseDTO: ServiceUseCaseDTO) -> AddServiceResultCodable {
        
        return AddServiceResultCodable(
            name: serviceUseCaseDTO.name,
            description: serviceUseCaseDTO.description,
            duration: serviceUseCaseDTO.duration,
            howMutch: serviceUseCaseDTO.howMutch,
            id: serviceUseCaseDTO.id, 
            uidFirebase: serviceUseCaseDTO.uidFirebase
        )
    }
    
    
}
