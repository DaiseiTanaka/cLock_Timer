//
//  SquareProgressView.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/03/19.
//

import SwiftUI

struct SquareProgressView: View {
    @EnvironmentObject var timeManager: TimeManager

    var value: CGFloat
    var baseColor: Color = Color.blue.opacity(0.1)

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .trailing) {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(self.baseColor)
                    Rectangle()
                        .fill(returnRectanglerColor(runtime: value * self.timeManager.taskTime).opacity(0.5))
                        .frame(minWidth: 0, idealWidth:self.getProgressBarWidth(geometry: geometry),
                               maxWidth: self.getProgressBarWidth(geometry: geometry))
                        .cornerRadius(2)
                }
            }
        }
    }

    func getProgressBarWidth(geometry:GeometryProxy) -> CGFloat {
        let frame = geometry.frame(in: .global)
        return frame.size.width * value
    }
    
    // タスク実行バーの色を返す
    private func returnRectanglerColor(runtime: Double) -> Color {
        if runtime < self.timeManager.taskTime {
            return Color.red
            
        } else if runtime <= self.timeManager.taskTime * 1.5 {
            return Color.green
            
        } else {
            return Color.blue
            
        }
    }
}
