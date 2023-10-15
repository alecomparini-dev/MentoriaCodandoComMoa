//  Created by Alessandro Comparini on 05/09/23.
//

import Foundation

public class Environment {
    
    private static let ENV = "ENV"
    
    public enum Variables: String {
        case apiBaseUrl = "API_BASE_URL"
        case apiBaseCEP = "API_BASE_CEP"
        case uIdFirebase = "UID_FIREBASE"
        case defaultTheme = "DEFAULT_THEME"
    }
    
    public static func variable(_ key: Environment.Variables) -> String {
        let enviroment = Bundle.main.infoDictionary![ENV] as! [String: Any]
        return enviroment[key.rawValue] as! String
    }
    
}
