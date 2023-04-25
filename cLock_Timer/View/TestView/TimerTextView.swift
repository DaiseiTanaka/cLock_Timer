//
//  TimerTextView.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/04/24.
//

import SwiftUI

struct TimerTextView: View {
    
    var timerString: String
    
    init() {
        timerString = "--:--"
    }
    
    @State private var stringList: [String] = ["-", "-", ":", "-", "-"]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<stringList.count) { index in
                ZStack {
                    Text(stringList[index])
                }
                .frame(width: 40, height: 80)
            }
        }
        .onAppear {
            returnStringList()
        }
    }
    
    private func returnStringList() {
        var list: [String] = []
        for string in timerString {
            list.append(String(string))
        }
        self.stringList = list
    }
}

struct TimerTextView_Previews: PreviewProvider {
    static var previews: some View {
        TimerTextView()
    }
}
