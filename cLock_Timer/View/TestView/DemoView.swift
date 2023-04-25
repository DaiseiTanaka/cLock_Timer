//
//  DemoView.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/04/21.
//

import SwiftUI

struct DemoView: View {
    @State var defaultSelection: Int = 1
    
    var body: some View {
        TabView(selection: $defaultSelection) {
            ZStack {
                Text("")
            }
            .tag(0)
            .tabItem {
                Image(systemName: "calendar")
                    .bold()
                Text("データ")
            }
            
            ZStack {
                Text("")
            }
            .tag(2)
            .tabItem {
                Image(systemName: "hare")
                    .bold()
                Text("キャラクター")
            }
            
            ZStack {
                TaskView()
                //.redacted(reason: loadContentView ? .placeholder : [])
                
            }
            .tag(1)
            .tabItem {
                Image(systemName: "timer")
                    .bold()
                Text("タイマー")
            }
            
            ZStack {
                Text("")
            }
            .tag(3)
            .tabItem {
                Image(systemName: "p.circle")
                    .bold()
                Text("ポイント")
            }
            
            ZStack {
                Text("")
            }
            .tag(4)
            .tabItem {
                Image(systemName: "slider.horizontal.3")
                    .bold()
                Text("設定")
            }
        }
    }
}

struct DemoView_Previews: PreviewProvider {
    static var previews: some View {
        DemoView()
    }
}
