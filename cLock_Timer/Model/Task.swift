//
//  Task.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/03/17.
//

import SwiftUI

// Task Model and Sample Tasks
// Array of Tasks
struct Task: Codable {
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
}

struct UsedTimeData: Codable {
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
}

// Total Task Meta View
struct TaskMetaData: Codable {
    var id = UUID().uuidString
    var task: [Task]
    var duration: Double
    var runtime: Double
    var taskDate: Date
    var usedTimeData: [UsedTimeData]
}

// Total Task Meta View for Backup
struct BackupTaskMetaData: Codable {
    var id = UUID().uuidString
    var task: [Task]
    var duration: Double
    var runtime: Double
    var taskDate: Date
}

// Sample Date for Testing
func getSampleDate(offset: Int) -> Date {
    let calender = Calendar.current
    
    let date = calender.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}
