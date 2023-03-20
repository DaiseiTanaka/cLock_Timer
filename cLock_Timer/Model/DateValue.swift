//
//  DateValue.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/03/17.
//

import SwiftUI

// Date Value Model
struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
