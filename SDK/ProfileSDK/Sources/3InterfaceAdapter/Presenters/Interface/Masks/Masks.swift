//  Created by Alessandro Comparini on 19/10/23.
//

import Foundation

public enum TypeMasks {
    case cellPhoneMask
    case CPFMask
    case dateMask
    case CEPMask
}

public protocol Masks {
    func formatString(_ string: String?) -> String
    func formatStringWithRange(range: NSRange, string: String?) -> String
}
