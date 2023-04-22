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
            VStack(spacing: 0) {
                if self.timeManager.autoRefreshFlag {
                    Text(self.timeManager.displayTimer())
                        .font(Font(UIFont.monospacedDigitSystemFont(ofSize: portraitOrNotFlag ? self.timeManager.timerFontSizePortrait : self.timeManager.timerFontSizeSide, weight: .medium)))
                        .minimumScaleFactor(0.1)
                    
                    if !self.timeManager.notShowTotalTimeFlag {
                        Text("Total. \(self.timeManager.runtimeToString(time: self.timeManager.runtime, second: true, japanease: false, onlyMin: false))")
                            .font(Font(UIFont.monospacedDigitSystemFont(ofSize: totalTimeFontSize, weight: .regular)))
                            .foregroundColor(Color(UIColor.systemGray4))
                    }
                    
                } else {
                    Text("\(self.timeManager.updatedTimer)")
                        .font(Font(UIFont.monospacedDigitSystemFont(ofSize: portraitOrNotFlag ? self.timeManager.timerFontSizePortrait : self.timeManager.timerFontSizeSide, weight: .medium)))
                        .minimumScaleFactor(0.1)
                    
                    if !self.timeManager.notShowTotalTimeFlag {
                        Text("Total. \(self.timeManager.updatedTotalTimer)")
                            .font(Font(UIFont.monospacedDigitSystemFont(ofSize: totalTimeFontSize, weight: .regular)))
                            .foregroundColor(Color(UIColor.systemGray4))
                    }
                }
            }
            
            floatingItems
            
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
        .onAppear {
            updateOrientation()
        }
        // 画面の向きが変わったことを検知
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            orientation = UIDevice.current.orientation
        }
        // 画面の向きが変わった時の処理　.onReceive内で実行したら不具合があったため切り離した
        .onChange(of: orientation) { _ in
            //withAnimation {
                updateOrientation()
            //}
        }
    }
    
    var floatingItems: some View {
        VStack {
            HStack {
                Spacer()
                
                if self.timeManager.timerShowSlider {
                    Button(action: {
                        let impactLight = UIImpactFeedbackGenerator(style: .light)
                        impactLight.impactOccurred()
                        
                        withAnimation {
                            self.timeManager.timerShowSlider = false
                        }
                    }){
                        Image(systemName: "chevron.right")
                            .resizable()
                            .foregroundColor(Color.gray)
                            .padding(.trailing, 10)
                            .frame(width: 20, height: 20)
                    }
                    
                    Slider(value: portraitOrNotFlag ? self.$timeManager.timerFontSizePortrait : self.$timeManager.timerFontSizeSide, in: portraitOrNotFlag ? 40...300 : 100...300)
                        .padding(.trailing, 15)
                        .frame(width: 160)
                    
                } else {
                    Button(action: {
                        let impactLight = UIImpactFeedbackGenerator(style: .light)
                        impactLight.impactOccurred()
                        
                        withAnimation {
                            self.timeManager.timerShowSlider = true
                        }
                    }){
                        Image(systemName: "slider.horizontal.below.rectangle")
                            .resizable()
                            .foregroundColor(Color.gray)
                            .frame(width: 20, height: 20)
                    }
                    .padding(.trailing, 15)

                }
                
                Button(action: {
                    dismiss()
                }){
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .foregroundColor(Color.gray)
                        .frame(width: 30, height: 30)
                }
            }
            .padding(.top, 10)
            .padding(.trailing, 20)

            Spacer()
        }
    }
    
    // 画面の向きによって変化させる変数を更新
    private func updateOrientation() {
        portraitOrNotFlag = self.timeManager.returnOrientation()
        // 初回アプリ立ち上げ時にUserDefaultにデータがない状態でフォントサイズをロードすると、めちゃくちゃ小さくなってしまうから、更新。
        if self.timeManager.timerFontSizePortrait < 40 || self.timeManager.timerFontSizeSide < 100 {
            self.timeManager.timerFontSizePortrait = 60
            self.timeManager.timerFontSizeSide = 130
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
