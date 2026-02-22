//
//  DateFormat.swift
//  ServiceTracker
//
//  Created by Mohamed Ashik BUhari S on 22/02/26.
//

import Foundation


func formatDate(_ date: Date) -> String {
    let calendar = Calendar.current
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    formatter.dateStyle = .none
    let timeString = formatter.string(from: date)
    
    if calendar.isDateInToday(date) {
        return "Today, \(timeString)"
    } else if calendar.isDateInTomorrow(date) {
        return "Tomorrow, \(timeString)"
    } else if calendar.isDateInYesterday(date) {
        return "Yesterday, \(timeString)"
    } else {
        formatter.dateFormat = "dd/MM/yyyy"
        let dateString = formatter.string(from: date)
        return "\(dateString), \(timeString)"
    }
}
