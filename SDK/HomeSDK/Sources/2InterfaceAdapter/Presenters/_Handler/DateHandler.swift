//  Created by Alessandro Comparini on 12/12/23.
//

import Foundation

public struct DateHandler {
    
    public static func getCurrentDate() -> (year: Int, month: Int, day: Int) {
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let day = calendar.component(.day, from: currentDate)
        return (year, month, day)
    }
    
    public static func separateDate(_ universalDate: String) -> (year: Int, month: Int, day: Int, hours: Int?, min: Int?, sec: Int?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        //TODO: TO IMPROVE
        var date = Date()
        if let dateFormatted = dateFormatter.date(from: universalDate) {
            date = dateFormatted
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            if let dateFormatted = dateFormatter.date(from: universalDate) {
                date = dateFormatted
            } else {
                return (0, 0, 0, nil, nil, nil)
            }
        }
        
        let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
            
            return (
                year: components.year ?? 0,
                month: components.month ?? 0,
                day: components.day ?? 0,
                hours: components.hour,
                min: components.minute,
                sec: components.second
            )
    }
    
    public static func getMonthName(_ month: Int) -> String {
        return [
            1: "Janeiro",
            2: "Fevereiro",
            3: "Março",
            4: "Abril",
            5: "Maio",
            6: "Junho",
            7: "Julho",
            8: "Agosto",
            9: "Setembro",
            10: "Outubro",
            11: "Novembro",
            12: "Dezembro"
        ][month] ?? ""
    }
    
    public static func getMonthInt(_ monthPTBR: String) -> Int? {
        return [
            "janeiro": 1,
            "fevereiro": 2,
            "março": 3 ,
            "abril": 4 ,
            "maio": 5 ,
            "junho": 6 ,
            "julho": 7 ,
            "agosto": 8 ,
            "setembro": 9 ,
            "outubro": 10 ,
            "novembro": 11 ,
            "dezembro": 12
        ][monthPTBR.lowercased()]
    }
    
    public static func dayWeekName(_ dayWeek: Int) -> String {
        return [
            1: "Domingo",
            2: "Segunda-feira",
            3: "Terça-feira",
            4: "Quarta-feira",
            5: "Quinta-feira",
            6: "Sexta-feira",
            7: "Sábado",
        ][dayWeek] ?? ""
    }
    
    public static func dayWeek(_ date: String) -> Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        guard let date = formatter.date(from: date ) else { return nil }
        
        let calendar = Calendar.current
        
        return calendar.component(.weekday, from: date)
    }
}
