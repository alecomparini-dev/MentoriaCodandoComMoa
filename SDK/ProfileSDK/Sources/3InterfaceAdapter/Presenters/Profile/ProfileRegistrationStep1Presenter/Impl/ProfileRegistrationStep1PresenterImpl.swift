//  Created by Alessandro Comparini on 16/10/23.
//

import Foundation


public enum FieldsRequired {
    case name
    case CPF
    case dateOfBirth
    case cellPhoneNumber
    case fieldOfWork
}


public protocol ProfileRegistrationStep1PresenterOutput: AnyObject {
    func error(_ error: String)
    func validations(validationsError: String?, fieldsRequired: [FieldsRequired])
    func success()
}

public class ProfileRegistrationStep1PresenterImpl: ProfileRegistrationStep1Presenter {
    public weak var outputDelegate: ProfileRegistrationStep1PresenterOutput?
    
    private let cpfValidator: CPFValidations
    
    public init(cpfValidator: CPFValidations) {
        self.cpfValidator = cpfValidator
    }
    
    public func continueRegistrationStep2(_ profilePresenterDTO: ProfilePresenterDTO) {
        if !validations(profilePresenterDTO) {
            return
        }
        outputDelegate?.success()
    }

    
//  MARK: - PRIVATE AREA
    private func validations(_ profilePresenterDTO: ProfilePresenterDTO) -> Bool {
        var failsMessage: String?
        
        let fieldsRequired = isValidFieldsRequired(profilePresenterDTO)
        
        if let failMsg = isValidCPF(profilePresenterDTO.cpf ?? "") {
            failsMessage = "\n" + failMsg
        }
        
        if let failMsg = isValidDateOfBirth(profilePresenterDTO.dateOfBirth ?? "") {
            failsMessage = (failsMessage ?? "") + "\n" + failMsg
        }
        
        if let failMsg = isValidCellPhone(profilePresenterDTO.cellPhoneNumber ?? "") {
            failsMessage = (failsMessage ?? "") + "\n" + failMsg
        }
        
        if failsMessage != nil || !fieldsRequired.isEmpty {
            outputDelegate?.validations(validationsError: failsMessage, fieldsRequired: fieldsRequired)
            return false
        }
        
        return true
    }
    
    private func isValidFieldsRequired(_ profilePresenterDTO: ProfilePresenterDTO) -> [FieldsRequired] {
        var fieldsRequired: [FieldsRequired] = []
        
        if profilePresenterDTO.name?.isEmpty ?? true {
            fieldsRequired.append(.name)
        }
        
        if profilePresenterDTO.cpf?.isEmpty ?? true {
            fieldsRequired.append(.CPF)
        }

        if profilePresenterDTO.dateOfBirth?.isEmpty ?? true {
            fieldsRequired.append(.dateOfBirth)
        }
        
        if profilePresenterDTO.cellPhoneNumber?.isEmpty ?? true {
            fieldsRequired.append(.cellPhoneNumber)
        }
        
        if profilePresenterDTO.fieldOfWork?.isEmpty ?? true {
            fieldsRequired.append(.fieldOfWork)
        }
        
        return fieldsRequired
    }
    
    private func isValidCPF(_ cpf: String) -> String? {
        if cpf.isEmpty {return nil}
        
        if !cpfValidator.validate(cpf: cpf) {
            return "CPF Inválido"
        }
        return nil
    }
    
    private func isValidDateOfBirth(_ dateString: String) -> String? {
        if dateString.isEmpty {return nil}
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        guard let inputDate = dateFormatter.date(from: dateString) else { return "Data Inválida"}
        
        let currentDate = Date()
        if inputDate > currentDate {
            return "Data deve ser menor que data atual"
        }

        return nil
    }

    private func isValidCellPhone(_ cellPhone: String) -> String? {
        if cellPhone.isEmpty {return nil}
        let cellPhone = cellPhone.replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: " ", with: "")
        
        if cellPhone.count != 11 {
            return "Número do celular inválido"
        }
        return nil
    }
    
    
}
