//  Created by Alessandro Comparini on 11/12/23.
//

import Foundation

import HomeUseCases

public struct ScheduleUseCaseDTOMapper {
    
    func toScheduleGatewayDTO(_ scheduleUseCaseDTO: ScheduleUseCaseDTO) -> ScheduleGatewayDTO {
        return ScheduleGatewayDTO(
            id: scheduleUseCaseDTO.id,
            address: scheduleUseCaseDTO.address,
            clientID: scheduleUseCaseDTO.clientID,
            clientName: scheduleUseCaseDTO.clientName,
            serviceID: scheduleUseCaseDTO.serviceID,
            serviceName: scheduleUseCaseDTO.serviceName,
            dateInitialSchedule: scheduleUseCaseDTO.dateInitialSchedule,
            dateFinalSchedule: scheduleUseCaseDTO.dateFinalSchedule)
    }
    
}
