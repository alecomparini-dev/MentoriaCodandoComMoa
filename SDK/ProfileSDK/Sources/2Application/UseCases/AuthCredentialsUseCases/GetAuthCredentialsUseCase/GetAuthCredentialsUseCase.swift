//  Created by Alessandro Comparini on 06/11/23.
//

import Foundation

public protocol GetAuthCredentialsUseCase {
    func getCredentials() throws -> (email: String, password: String)?
}
