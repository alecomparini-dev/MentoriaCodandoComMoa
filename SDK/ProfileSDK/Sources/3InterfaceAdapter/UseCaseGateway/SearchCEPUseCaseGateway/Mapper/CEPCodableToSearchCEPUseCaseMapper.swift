//  Created by Alessandro Comparini on 14/10/23.
//

import Foundation
import ProfileUseCases

public struct CEPCodableToSearchCEPUseCase {
    
    static func mapper(_ cepCodable: CEPCodable) -> SearchCEPUseCaseDTO.Output {
        
        return SearchCEPUseCaseDTO.Output(
            CEP: cepCodable.result?.zipcode ?? "",
            street: cepCodable.result?.street ?? "",
            neighborhood: cepCodable.result?.district ?? "",
            city: cepCodable.result?.city ?? "",
            stateShortname: cepCodable.result?.stateShortname ?? "",
            state: cepCodable.result?.state
        )
        
    }
    
}
