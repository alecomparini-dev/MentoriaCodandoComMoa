//  Created by Alessandro Comparini on 14/10/23.
//

import Foundation

import ProfileUseCases

// MARK: - CEPCodable
public struct CEPCodable: Codable {
    public var meta: Meta?
    public var result: CEPResult?

    public init(meta: Meta?, result: CEPResult?) {
        self.meta = meta
        self.result = result
    }
    
}

//  MARK: - EXTENSTION MAPPER

extension CEPCodable {
    
    func mapperToDTO() -> SearchCEPUseCaseDTO.Output {
        return SearchCEPUseCaseDTO.Output(
            CEP: self.result?.zipcode ?? "",
            street: self.result?.street ?? "",
            neighborhood: self.result?.district ?? "",
            city: self.result?.city ?? "",
            stateShortname: self.result?.stateShortname ?? "",
            state: self.result?.state
        )
    }
}
