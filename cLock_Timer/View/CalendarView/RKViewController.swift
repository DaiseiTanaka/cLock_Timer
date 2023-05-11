//
//  RKViewController.swift
//  RKCalendar
//
//  Created by Raffi Kian on 7/14/19.
//  Copyright © 2019 Raffi Kian. All rights reserved.
//

import SwiftUI

struct RKViewController: View {
    @EnvironmentObject var timeManager: TimeManager
    
    @Binding var isPresented: Bool
    
    @ObservedObject var rkManager: RKManager
    
    @State var numberOfMonths: Int
    
    // 画面の向きを制御
    @State var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State var portraitOrNotFlag: Bool = true
    
    var body: some View {
        ZStack {
            ScrollViewReader { (proxy: ScrollViewProxy) in
                ScrollView {
                    VStack {
                        ForEach(0..<numberOfMonths) { index in
                            RKMonth(isPresented: self.$isPresented, rkManager: self.rkManager, monthOffset: index)
                                .id(index)
                        }
                        .padding(.top, 20)
                    }
                    .padding(.bottom, 100)
                }
                .listStyle(.plain)
                .onAppear {
                    scrollToThisMonth(proxy: proxy)
                }
                .onChange(of: self.timeManager.tabDataViewTapped) { _ in
                    withAnimation {
                        scrollToThisMonth(proxy: proxy)
                    }
                }
            }
            VStack {
                RKWeekdayHeader(rkManager: self.rkManager)
                Spacer()
            }
        }
        // 画面の向きが変わったことを検知
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            orientation = UIDevice.current.orientation
        }
        // 画面の向きが変わった時の処理　.onReceive内で実行したら不具合があったため切り離した
        .onChange(of: orientation) { _ in
            portraitOrNotFlag = self.timeManager.returnOrientation()
        }
    }
    
    func scrollToThisMonth(proxy: ScrollViewProxy) {
        let target: CGFloat = 0.0
        proxy.scrollTo(numberOfMonths-1, anchor: UnitPoint(x: 0.5, y: target))
    }
    
//    func numberOfMonths() -> Int {
//        return rkManager.calendar.dateComponents([.month], from: rkManager.minimumDate, to: RKMaximumDateMonthLastDay()).month! + 1
//    }
//    
//    func RKMaximumDateMonthLastDay() -> Date {
//        var components = rkManager.calendar.dateComponents([.year, .month, .day], from: rkManager.maximumDate)
//        components.month! += 1
//        components.day = 0
//        
//        return rkManager.calendar.date(from: components)!
//    }
}

#if DEBUG
struct RKViewController_Previews : PreviewProvider {
    static var previews: some View {
        Group {
//            RKViewController(isPresented: .constant(false), rkManager: RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0))
//            RKViewController(isPresented: .constant(false), rkManager: RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*32), mode: 0))
//                .environment(\.colorScheme, .dark)
//                .environment(\.layoutDirection, .rightToLeft)
        }
    }
}
#endif

