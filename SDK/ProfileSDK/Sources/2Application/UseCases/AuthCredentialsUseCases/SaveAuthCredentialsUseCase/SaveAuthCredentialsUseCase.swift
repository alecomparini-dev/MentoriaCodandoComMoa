//  Created by Alessandro Comparini on 05/11/23.
//

import Foundation

public protocol SaveAuthCredentialsUseCase {
    func save(email: String, password: String) async throws -> Bool
}
