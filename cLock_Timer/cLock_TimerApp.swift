//
//  cLock_TimerApp.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/03/15.
//

import SwiftUI

@main
struct cLock_TimerApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(TimeManager())
        }
    }
}
