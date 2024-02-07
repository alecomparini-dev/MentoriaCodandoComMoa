//  Created by Alessandro Comparini on 17/10/23.
//

import Foundation

import ProfileUseCases


public struct ViaCEPCodable: Codable {
    public var cep: String?
    public var logradouro: String?
    public var complemento: String?
    public var bairro: String?
    public var localidade: String?
    public var uf: String?
    public var ibge: String?
    public var gia: String?
    public var ddd: String?
    public var siafi: String?
    
    public init(cep: String? = nil, logradouro: String? = nil, complemento: String? = nil, bairro: String? = nil, localidade: String? = nil, uf: String? = nil, ibge: String? = nil, gia: String? = nil, ddd: String? = nil, siafi: String? = nil) {
        self.cep = cep
        self.logradouro = logradouro
        self.complemento = complemento
        self.bairro = bairro
        self.localidade = localidade
        self.uf = uf
        self.ibge = ibge
        self.gia = gia
        self.ddd = ddd
        self.siafi = siafi
    }

}

//  MARK: - EXTENSTION MAPPER

extension ViaCEPCodable {
    
    func mapperToDTO() -> SearchCEPUseCaseDTO.Output {
        return SearchCEPUseCaseDTO.Output(
            CEP: self.cep ?? "",
            street: self.logradouro ?? "",
            neighborhood: self.bairro ?? "",
            city: self.localidade ?? "",
            stateShortname: self.uf ?? "",
            state: self.uf ?? ""
        )
    }
}
