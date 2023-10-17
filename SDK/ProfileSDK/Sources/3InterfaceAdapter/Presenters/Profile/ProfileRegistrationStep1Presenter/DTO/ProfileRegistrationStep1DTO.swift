//
//  File.swift
//  
//
//  Created by Alessandro Comparini on 16/10/23.
//

import Foundation

public struct ProfileRegistrationStep1DTO {
    public let cpf: String?
    
    public init(cpf: String?) {
        self.cpf = cpf
    }
}
