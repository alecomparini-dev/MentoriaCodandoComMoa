//  Created by Alessandro Comparini on 30/10/23.
//

import Foundation


public struct NumberFormatterHandler {
    
    static public func convertDoublePT_BRToEN_US(_ value: String?) -> Double? {
        guard let value else {return nil}
        
        if Double(value) != nil { return numberFormater(identifier: "en_US", "\(value)") }
        
        guard let valueBR: Double = numberFormater(identifier: "pt_BR", value) else { return nil }
        
        return numberFormater(identifier: "en_US", "\(valueBR)")
    }
    
    static public func convertDoubleEN_USToPT_BR(_ value: String?) -> String? {
        guard let value else {return nil}
        
        let formatterUS = createNumberFormater("en_US")
        
        guard let valueUS = formatterUS.number(from: value) else {return nil}
        
        return numberFormaterString(identifier: "pt_BR", valueUS)
    }
    
    
    static public func numberFormater(identifier: String, _ value: String?) -> Double? {
        guard let value else { return nil }
        
        let formatter = createNumberFormater(identifier)
        
        guard let number = formatter.number(from: value) else { return nil }
        
        return Double(truncating: number)
    }
    
    
    static public func numberFormaterString(identifier: String, _ value: NSNumber?) -> String? {
        guard let value else { return nil }
        
        let formatter = createNumberFormater(identifier)
        
        return formatter.string(from: value)
    }
    
    private static func createNumberFormater(_ identifier: String) -> NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: identifier)
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        return numberFormatter
    }
}
