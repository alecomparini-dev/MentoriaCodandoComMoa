//  Created by Alessandro Comparini on 09/12/23.
//

import Foundation
import CoreData


@objc(CDSchedule)
public class CDSchedule: NSManagedObject {
    @NSManaged public var id: UUID?
    @NSManaged public var address: String?
    @NSManaged public var clientID: Int32
    @NSManaged public var clientName: String?
    @NSManaged public var serviceID: Int32
    @NSManaged public var serviceName: String?
    @NSManaged public var dateInitialSchedule: Date?
    @NSManaged public var dateFinalSchedule: Date?
    
}

