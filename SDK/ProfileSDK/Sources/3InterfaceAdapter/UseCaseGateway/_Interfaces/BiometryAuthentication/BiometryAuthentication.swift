//  Created by Alessandro Comparini on 02/11/23.
//

import Foundation

public protocol BiometryAuthentication {
    func checkBiometry() -> BiometryAuthenticationGatewayDTO
    func authenticate(reason: String?, cancelTitle: String?) -> BiometryAuthenticationGatewayDTO
}
