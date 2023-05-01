//
//  RKCell.swift
//  RKCalendar
//
//  Created by Raffi Kian on 7/14/19.
//  Copyright © 2019 Raffi Kian. All rights reserved.
//

import SwiftUI

struct RKCell: View {
    @EnvironmentObject var timeManager: TimeManager
    
    var rkDate: RKDate
    
    var cellWidth: CGFloat
    
    var runtime: Double
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text(rkDate.getText())
                    .fontWeight(rkDate.getFontWeight())
                    .foregroundColor(rkDate.getTextColor())
                    .font(.system(size: 12))
                    //.cornerRadius(cellWidthPhone)
            }
            .frame(maxWidth: .infinity)
            .background(rkDate.getBackgroundColor())
            
            Spacer(minLength: 0)
            
            if runtime >= 0 {
                ZStack {
                    VStack {
                        Spacer(minLength: 0)
                        
                        self.timeManager.returnRectanglerColor(runtime: runtime, opacity: 1.0)
                            .cornerRadius(5)
                            .frame(maxHeight: returnRectangleHeight())
                    }
                    
                    VStack {
                        Spacer()
                        Text("\(self.timeManager.runtimeToString(time: runtime, second: false, japanease: false, onlyMin: false))")
                            .foregroundColor(.white)
                            .font(.footnote.bold())
                            .padding(.bottom, 2)
                    }
                }
            }
        }
        .frame(width: cellWidth, height: cellWidth*1.5)

    }
    
    private func returnRectangleHeight() -> CGFloat {
        var height: CGFloat = 0
        let minHeight: CGFloat = 20
        let maxHeight: CGFloat = cellWidth * 1.5 - 20
        let diffHeight: CGFloat = maxHeight - minHeight
        let threshold: Double = self.timeManager.taskTime * 2.0
        let ratio: Double = runtime / threshold
        
        if runtime <= threshold {
            height = minHeight + diffHeight * ratio
        } else {
            height = maxHeight
        }
//        if runtime < self.timeManager.taskTime {
//            height = minHeight + middleHeight * runtime / self.timeManager.taskTime
//        } else if runtime <= self.timeManager.taskTime * 2.0 {
//            height = middleHeight + middleHeight * (runtime - self.timeManager.taskTime) / self.timeManager.taskTime
//        } else {
//            height = maxHeight
//        }
        
        return height
    }
}

#if DEBUG
struct RKCell_Previews : PreviewProvider {
    static var previews: some View {
        Group {
//            RKCell(rkDate: RKDate(date: Date(), rkManager: RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0), isDisabled: false, isToday: false, isSelected: false, isBetweenStartAndEnd: false), cellWidthPhone: CGFloat(32))
//                .previewDisplayName("Control")
//            RKCell(rkDate: RKDate(date: Date(), rkManager: RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0), isDisabled: true, isToday: false, isSelected: false, isBetweenStartAndEnd: false), cellWidthPhone: CGFloat(32))
//                .previewDisplayName("Disabled Date")
//            RKCell(rkDate: RKDate(date: Date(), rkManager: RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0), isDisabled: false, isToday: true, isSelected: false, isBetweenStartAndEnd: false), cellWidthPhone: CGFloat(32))
//                .previewDisplayName("Today")
//            RKCell(rkDate: RKDate(date: Date(), rkManager: RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0), isDisabled: false, isToday: false, isSelected: true, isBetweenStartAndEnd: false), cellWidthPhone: CGFloat(32))
//                .previewDisplayName("Selected Date")
//            RKCell(rkDate: RKDate(date: Date(), rkManager: RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0), isDisabled: false, isToday: false, isSelected: false, isBetweenStartAndEnd: true), cellWidthPhone: CGFloat(32))
//                .previewDisplayName("Between Two Dates")
        }
        .previewLayout(.fixed(width: 300, height: 70))
            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
    }
}
#endif


