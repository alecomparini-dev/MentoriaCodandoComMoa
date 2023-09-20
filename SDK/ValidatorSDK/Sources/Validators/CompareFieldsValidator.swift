//  Created by Alessandro Comparini on 18/09/23.
//

import Foundation


public final class CompareFieldsValidator: Validator, Equatable {

    
    private let fieldName: String
    private let fieldNameToCompare: String
    private let fieldLabel: String
    
    public init(fieldName: String, fieldNameToCompare: String, fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldNameToCompare = fieldNameToCompare
        self.fieldLabel = fieldLabel
    }
    
    public func validate(fields: [FieldName : FieldValue]) -> Bool {
        guard let nameValue = fields[fieldName] ,
              let nameToCompareValue = fields[fieldNameToCompare] else { return false }
        
        if nameValue != nameToCompareValue {
            return true
        }
        
        return true
    }
    
    
    public static func == (lhs: CompareFieldsValidator, rhs: CompareFieldsValidator) -> Bool {
        return
            lhs.fieldLabel == rhs.fieldLabel &&
            lhs.fieldName == rhs.fieldName &&
            lhs.fieldNameToCompare == rhs.fieldNameToCompare
    }
    
}
