//  Created by Alessandro Comparini on 02/11/23.
//

import Foundation

public protocol CheckBiometryUseCase {
    func check() throws -> CheckBiometryUseCaseDTO
}
