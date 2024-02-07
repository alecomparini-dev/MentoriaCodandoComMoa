//  Created by Alessandro Comparini on 19/10/23.
//

import Foundation

import CustomComponentsSDK
import ProfilePresenters

public class CEPMask: Masks {

    private let mask: MaskBuilder
    
    public init() {
        self.mask = MaskBuilder()
            .setCEPMask()
    }
    
    public func formatString(_ string: String?) -> String {
        guard let string else {return K.Strings.empty}
        return mask.formatString(string)
    }
    
    public func formatStringWithRange(range: NSRange, string: String?) -> String {
        guard let string else {return K.Strings.empty}
        return mask.formatStringWithRange(range: range, string: string)
    }
    
    public func cleanText(_ text: String) -> String {
        return mask.cleanText(text)
    }
    
}
