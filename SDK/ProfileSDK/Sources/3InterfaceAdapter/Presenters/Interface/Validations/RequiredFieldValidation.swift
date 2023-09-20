//  Created by Alessandro Comparini on 20/09/23.
//

import Foundation


public protocol RequiredFieldsValidation {
    typealias FieldNameFails = String
    typealias FieldName = String
    typealias FieldValue = String
    func validate(fields: [FieldName: FieldValue] ) -> [FieldNameFails]
}
