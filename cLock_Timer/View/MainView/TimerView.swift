//
//  TimerView.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/04/21.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var timeManager: TimeManager
    @Environment(\.dismiss) var dismiss

    //　タイマーのフォントのサイズ
    /// 縦画面
    @State private var timerFontSize: CGFloat = 55
    ///　横画面
    @State private var timerFontSizeSide: CGFloat = 120
    //　合計タスク実行時間のフォントのサイズ
    @State private var totalTimeFontSize: CGFloat = 30
    
    // 画面の向きを制御
    @State var orientation: UIDeviceOrientation
    @State var portraitOrNotFlag: Bool = true
    init() {
        self._orientation = State(wrappedValue: UIDevice.current.orientation)
    }
    
    var body: some View {
        ZStack {
            // 縦画面
            if portraitOrNotFlag {
                VStack(spacing: 0) {
                    if self.timeManager.autoRefreshFlag {
                        Text(self.timeManager.displayTimer())
                            .font(Font(UIFont.monospacedDigitSystemFont(ofSize: timerFontSize, weight: .medium)))
                        
                        if self.timeManager.showTotalTimeFlag {
                            Text("Total. \(self.timeManager.runtimeToString(time: self.timeManager.runtime, second: true, japanease: false, onlyMin: false))")
                                .font(Font(UIFont.monospacedDigitSystemFont(ofSize: totalTimeFontSize, weight: .regular)))
                                .foregroundColor(Color(UIColor.systemGray4))
                        }
                        
                    } else {
                        Text("\(self.timeManager.updatedTimer)")
                            .font(Font(UIFont.monospacedDigitSystemFont(ofSize: timerFontSize, weight: .medium)))
                        
                        if self.timeManager.showTotalTimeFlag {
                            Text("Total. \(self.timeManager.updatedTotalTimer)")
                                .font(Font(UIFont.monospacedDigitSystemFont(ofSize: totalTimeFontSize, weight: .regular)))
                                .foregroundColor(Color(UIColor.systemGray4))
                        }
                    }
                }
            // 横画面
            } else {
                VStack(spacing: 0) {
                    if self.timeManager.autoRefreshFlag {
                        Text(self.timeManager.displayTimer())
                            .font(Font(UIFont.monospacedDigitSystemFont(ofSize: timerFontSizeSide, weight: .medium)))
                        
                        if self.timeManager.showTotalTimeFlag {
                            Text("Total. \(self.timeManager.runtimeToString(time: self.timeManager.runtime, second: true, japanease: false, onlyMin: false))")
                                .font(Font(UIFont.monospacedDigitSystemFont(ofSize: totalTimeFontSize, weight: .regular)))
                                .foregroundColor(Color(UIColor.systemGray4))
                        }
                        
                    } else {
                        Text("\(self.timeManager.updatedTimer)")
                            .font(Font(UIFont.monospacedDigitSystemFont(ofSize: timerFontSizeSide, weight: .medium)))
                        
                        if self.timeManager.showTotalTimeFlag {
                            Text("Total. \(self.timeManager.updatedTotalTimer)")
                                .font(Font(UIFont.monospacedDigitSystemFont(ofSize: totalTimeFontSize, weight: .regular)))
                                .foregroundColor(Color(UIColor.systemGray4))
                        }
                    }
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }){
                        HStack {
                            Spacer()
                            
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .foregroundColor(Color.gray)
                                .frame(width: 30, height: 30)
                                .padding(.top, 10)
                                .padding(.trailing, 20)
                        }
                    }
                }
                Spacer()
            }
            
            Color(UIColor.systemBackground)
                .onTapGesture {
                    viewTappedAction()
                }
                .opacity(0.01)
        }
        .onTapGesture {
            // 自動更新OFFの時、画面タップでタイマー更新
            viewTappedAction()
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
    
    // タイマー更新
    private func viewTappedAction() {
        if !self.timeManager.autoRefreshFlag {
            // バイブレーション
            let impactLight = UIImpactFeedbackGenerator(style: .light)
            impactLight.impactOccurred()
            
            // 画面をタップするとカウントダウンタイマーのUIを更新する
            self.timeManager.updateTimer()
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
            .environmentObject(TimeManager())

    }
}
