//  Created by Alessandro Comparini on 05/12/23.
//

import Foundation

public class AddSchedulePresenterImpl: AddSchedulePresenter {
    
    public enum DockID: String {
        case daysDock = "DAYS_DOCK"
        case hoursDock = "HOURS_DOCK"
    }
    
    public init() {}
    
    public func getCurrentMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        formatter.locale = Locale.current

        let descriptionMonth = formatter.string(from: Date())

        return translateMonth(descriptionMonth)
    }
    
    
    public func numberOfItemsDock(dockID: DockID) -> Int {
        switch dockID {
            case .daysDock:
                return calculateDaysOfCurrentMonth()
            
            case .hoursDock:
                return 16
        }
    }
    
    public func sizeOfItemsDock(dockID: DockID) -> CGSize {
        switch dockID {
            case .daysDock:
                return CGSize(width: 55, height: 65)
            
            case .hoursDock:
                return CGSize(width: 100, height: 48)
        }
    }
    
    
//  MARK: - PRIVATE AREA
    //TODO: Change to NSLocalizedString
    private func translateMonth(_ month: String) -> String {
        switch month.lowercased() {
            case "january":
                return "Janeiro"
            case "february":
                return "Fevereiro"
            case "march":
                return "Março"
            case "april":
                return "Abril"
            case "may":
                return "Maio"
            case "june":
                return "Junho"
            case "july":
                return "Julho"
            case "august":
                return "Agosto"
            case "september":
                return "Setembro"
            case "october":
                return "Outubro"
            case "november":
                return "Novembro"
            case "december" :
                return "Dezembro"
            default:
                return ""
        }
    }
    
    private func calculateDaysOfCurrentMonth() -> Int {
        let calendar = Calendar.current
        let componentDate = DateComponents(year: calendar.component(.year, from: Date()),
                                           month: calendar.component(.month, from: Date()))
        
        guard let date = calendar.date(from: componentDate) else { return 0 }
        
        let range = calendar.range(of: .day, in: .month, for: date)
        
        return range?.count ?? 0
    }
}
