//  Created by Alessandro Comparini on 18/09/23.
//

import Foundation

public final class RequiredFieldValidator {
    public typealias FieldNameFails = String
    private var fieldNames: [String] = []
    
    public init(fieldNames: [String]) {
        self.fieldNames = fieldNames
    }
    
    
    public func validate(fields: [String: String]) -> [FieldNameFails] {
            
                
        return []
    }
    
}
