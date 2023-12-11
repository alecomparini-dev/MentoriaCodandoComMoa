//  Created by Alessandro Comparini on 09/12/23.
//

import Foundation


public struct ScheduleGatewayDTO {
    public var id: UUID?
    public var clientID: NSNumber?
    public var clientName: String?
    public var serviceID: NSNumber?
    public var serviceName: String?
    public var dateInitialSchedule: Date?
    public var dateFinalSchedule: Date?
    
    public init(id: UUID? = nil, clientID: NSNumber? = nil, clientName: String? = nil, serviceID: NSNumber? = nil, serviceName: String? = nil, dateInitialSchedule: Date? = nil, dateFinalSchedule: Date? = nil) {
        self.id = id
        self.clientID = clientID
        self.clientName = clientName
        self.serviceID = serviceID
        self.serviceName = serviceName
        self.dateInitialSchedule = dateInitialSchedule
        self.dateFinalSchedule = dateFinalSchedule
    }
}


   
