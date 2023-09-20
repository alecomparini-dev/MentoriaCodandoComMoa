//  Created by Alessandro Comparini on 18/09/23.
//

import Foundation

public protocol Validator {
    typealias FieldName = String
    typealias FieldValue = String
    func validate(fields: [FieldName: FieldValue] ) -> Bool
}
