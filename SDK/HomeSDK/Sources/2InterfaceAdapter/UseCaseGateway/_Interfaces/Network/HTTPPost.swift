//  Created by Alessandro Comparini on 14/10/23.
//

import Foundation


public protocol HTTPPost {
    func post(url: URL, headers: [String: String]?, queryParameters: [String: String]?, bodyJsonData: Data?) async throws -> Data?
}
