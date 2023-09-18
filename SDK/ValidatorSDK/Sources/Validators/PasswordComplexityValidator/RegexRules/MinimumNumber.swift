//  Created by Alessandro Comparini on 18/09/23.
//

import Foundation

public class MinimumNumber: RegexRules {
    public var regex: String
    
    private let minimum: Int
    
    public init(regex: String = "(?=^.*\\d.*$)", minimum: Int = 1) {
        self.regex = regex
        self.minimum = minimum
        configure()
    }
    
    public func perform(_ value: String) -> Bool {
        let range = NSRange(location: 0, length: value.utf16.count)
        let regex = try! NSRegularExpression(pattern: regex)
        return regex.firstMatch(in: value,options: [], range: range) != nil
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        if minimum == 1 { return }
        
        regex = regex + "(?=^"
        for _ in 1...minimum {
            regex = regex + ".*\\d"
        }
        regex = regex + ".*$)"
    }
}
