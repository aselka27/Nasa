//
//  String+Extension.swift
//  Nasa
//
//  Created by саргашкаева on 29.06.2023.
//

import Foundation


extension String {
    func formatDateString() -> String {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            guard let date = dateFormatter.date(from: self) else {
                return ""
            }
            
            let calendar = Calendar.current
            let day = calendar.component(.day, from: date)
            
            dateFormatter.dateFormat = "d'\(getDaySuffix(day: day))' MMM yyyy"
            return dateFormatter.string(from: date)
    }
    
    func getDaySuffix(day: Int) -> String {
            if (11...13).contains(day % 100) {
                return "th"
            }
            switch day % 10 {
            case 1: return "st"
            case 2: return "nd"
            case 3: return "rd"
            default: return "th"
            }
        }
}
