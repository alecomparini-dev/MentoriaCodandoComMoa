//  Created by Alessandro Comparini on 09/12/23.
//

import Foundation
import CoreData


@objc(CDSchedule)
public class CDSchedule: NSManagedObjectModel {
    @NSManaged public var id: UUID?
    @NSManaged public var clientID: Int32
    @NSManaged public var clientName: String?
    @NSManaged public var serviceID: Int32
    @NSManaged public var serviceName: String?
    @NSManaged public var dateInitialSchedule: Date?
    @NSManaged public var dateFinalSchedule: Date?
    
    public convenience init(context: NSEntityDescription, id: UUID, clientID: Int32, clientName: String? = nil, serviceID: Int32, serviceName: String? = nil, dateInitialSchedule: Date? = nil, dateFinalSchedule: Date? = nil) {
        self.init()
        self.id = id
        self.clientID = clientID
        self.clientName = clientName
        self.serviceID = serviceID
        self.serviceName = serviceName
        self.dateInitialSchedule = dateInitialSchedule
        self.dateFinalSchedule = dateFinalSchedule
    }

}


   
