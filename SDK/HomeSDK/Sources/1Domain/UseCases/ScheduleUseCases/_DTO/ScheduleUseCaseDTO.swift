//  Created by Alessandro Comparini on 09/12/23.
//

import Foundation


public struct ScheduleUseCaseDTO: Identifiable {
    public let id: UUID = UUID()
    public let address: String?
    public var clientID: Int?
    public var clientName: String?
    public var serviceID: Int?
    public var serviceName: String?
    public var dateInitialSchedule: Date?
    public var dateFinalSchedule: Date?
    
    public init(address: String?, clientID: Int? = nil, clientName: String? = nil, serviceID: Int? = nil, serviceName: String? = nil, dateInitialSchedule: Date? = nil, dateFinalSchedule: Date? = nil) {
        self.address = address
        self.clientID = clientID
        self.clientName = clientName
        self.serviceID = serviceID
        self.serviceName = serviceName
        self.dateInitialSchedule = dateInitialSchedule
        self.dateFinalSchedule = dateFinalSchedule
    }
}
