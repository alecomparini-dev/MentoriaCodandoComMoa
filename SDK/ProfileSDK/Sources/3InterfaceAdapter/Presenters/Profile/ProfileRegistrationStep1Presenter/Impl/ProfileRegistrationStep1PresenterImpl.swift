//  Created by Alessandro Comparini on 16/10/23.
//

import Foundation


public protocol ProfileRegistrationStep1PresenterOutput: AnyObject {
    func error(_ error: String)
    func success(_ cepDTO: CEPDTO)
}

public class ProfileRegistrationStep1PresenterImpl: ProfileRegistrationStep1Presenter {
    public weak var outputDelegate: ProfileRegistrationStep1PresenterOutput?
    
    private let cpfValidator: CPFValidations
    
    public init(cpfValidator: CPFValidations) {
        self.cpfValidator = cpfValidator
    }
    
    public func continueRegistrationStep2(_ profileRegistrationStep1DTO: ProfileRegistrationStep1DTO) {
        if let msgInvalid = validations(profileRegistrationStep1DTO) {
            outputDelegate?.error(msgInvalid)
            return
        }
        outputDelegate?.success(CEPDTO())
    }

    
//  MARK: - PRIVATE AREA
    private func validations(_ profileRegistrationStep1DTO: ProfileRegistrationStep1DTO) -> String? {
        var failsMessage: String?
        
        if !cpfValidator.validate(cpf: profileRegistrationStep1DTO.cpf ?? "") {
            failsMessage = "CPF Inválido"
        }
        
        return failsMessage
    }
    
}
