//  Created by Alessandro Comparini on 14/10/23.
//

import Foundation

public struct Meta: Codable {
    public var currentPage, itemsPerPage, totalOfItems, totalOfPages: Int?

    public init(currentPage: Int?, itemsPerPage: Int?, totalOfItems: Int?, totalOfPages: Int?) {
        self.currentPage = currentPage
        self.itemsPerPage = itemsPerPage
        self.totalOfItems = totalOfItems
        self.totalOfPages = totalOfPages
    }
}
