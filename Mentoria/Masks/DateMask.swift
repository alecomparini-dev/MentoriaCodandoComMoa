//  Created by Alessandro Comparini on 19/10/23.
//

import Foundation

import CustomComponentsSDK
import ProfilePresenters

public class DateMask: Masks {
    
    private let mask: MaskBuilder
    
    public init(isDateISO8601: Bool = false) {
        self.mask = MaskBuilder()
        if isDateISO8601 {
            self.mask.setDateUniversalMask()
            return
        }
        self.mask.setDateMask()
    }
    
    public init(customMask: String) {
        self.mask = MaskBuilder()
            .setCustomMask(customMask)
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
