//  Created by Alessandro Comparini on 05/12/23.
//

import Foundation

public class AddSchedulePresenterImpl: AddSchedulePresenter {
    
    public enum DockID: String {
        case daysDock = "DAYS_DOCK"
        case hoursDock = "HOURS_DOCK"
    }
    
    public init() {}
    
    
    
    public func getWeekName(_ date: Date) -> String {
        let calendar = Calendar.current
        let dayWeek = calendar.component(.weekday, from: date)
        return getDayWeekName(dayWeek)
    }
    
    public func getMonthName(_ date: Date? = nil) -> String {
        let calendar = Calendar.current
        
        guard let date = (date == nil) ? Date() : date else { return "" }
        
        let month = calendar.component(.month, from: date)
        
        return getMonthName(month)
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
                return CGSize(width: 55, height: 70)
            
            case .hoursDock:
                return CGSize(width: 100, height: 40)
        }
    }
    
    
//  MARK: - PRIVATE AREA
    private func getMonthName(_ month: Int) -> String {
        switch month {
            case 1:
                return "Janeiro"
            case 2:
                return "Fevereiro"
            case 3:
                return "Março"
            case 4:
                return "Abril"
            case 5:
                return "Maio"
            case 6:
                return "Junho"
            case 7:
                return "Julho"
            case 8:
                return "Agosto"
            case 9:
                return "Setembro"
            case 10:
                return "Outubro"
            case 11:
                return "Novembro"
            case 12:
                return "Dezembro"
            default:
                return ""
        }
    }
    
    private func getDayWeekName(_ dayWeek: Int) -> String {
        switch dayWeek {
            case 1:
                return "Domingo"
            case 2:
                return "Segunda-feira"
            case 3:
                return "Terça-feira"
            case 4:
                return "Quarta-feira"
            case 5:
                return "Quinta-feira"
            case 6:
                return "Sexta-feira"
            case 7:
                return "Sábado"
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
