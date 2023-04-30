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
    
    @State private var showFloatingItems: Bool = true
    
    @State private var showFontListView: Bool = false
    
    @State private var timerFontSizePortrait: CGFloat = 70
    @State private var timerFontSizeSide: CGFloat = 70
    
    @State private var timerString: String = ""
    @State private var totalTimerString: String = ""
    @State private var timerFont: Font = Font.title
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Spacer()
                // 自動リフレッシュON
                if self.timeManager.autoRefreshFlag {
                    Text(self.timerString)
                    //Text(self.timeManager.displayTimer())
                        .font(returnFont(fontName: self.timeManager.selectedFontName, fontSize: CGFloat(portraitOrNotFlag ? self.timeManager.timerFontSizePortrait : self.timeManager.timerFontSizeSide)))
                        .minimumScaleFactor(0.1)
                        .onReceive(self.timeManager.timer, perform: { _ in
                            self.timerString = self.timeManager.displayTimer()
                                   })
                    
                    // 合計時間を表示
                    if !self.timeManager.notShowTotalTimeFlag {
                        //Text("Total. \(self.timeManager.runtimeToString(time: self.timeManager.runtime, second: true, japanease: false, onlyMin: false))")
                        Text("Total. \(self.totalTimerString)")
                            .font(returnFont(fontName: self.timeManager.selectedFontName, fontSize: totalTimeFontSize))
                            .foregroundColor(Color(UIColor.systemGray4))
                            .onReceive(self.timeManager.timer, perform: { _ in
                                self.totalTimerString = self.timeManager.runtimeToString(time: self.timeManager.runtime, second: true, japanease: false, onlyMin: false)
                                       })
                    }
                    
                // 自動リフレッシュOFF
                } else {
                    Text("\(self.timeManager.updatedTimer)")
                        .font(returnFont(fontName: self.timeManager.selectedFontName, fontSize: CGFloat(portraitOrNotFlag ? self.timeManager.timerFontSizePortrait : self.timeManager.timerFontSizeSide)))
                        .minimumScaleFactor(0.1)
                    
                    // 合計時間を表示
                    if !self.timeManager.notShowTotalTimeFlag {
                        Text("Total. \(self.timeManager.updatedTotalTimer)")
                            .font(returnFont(fontName: self.timeManager.selectedFontName, fontSize: totalTimeFontSize))
                            .foregroundColor(Color(UIColor.systemGray4))
                    }
                }
                Spacer()
            }
            .ignoresSafeArea()            
            
            if self.showFloatingItems {
                floatingItems
            }
                        
            Color(UIColor.systemBackground)
                .onTapGesture {
                    viewTappedAction()
                }
                .opacity(0.01)
            
        }
        .ignoresSafeArea()
        .statusBar(hidden: self.timeManager.showStatusBarFlag)
        .onTapGesture {
            // 自動更新OFFの時、画面タップでタイマー更新
            viewTappedAction()
        }
        .onAppear {
            updateOrientation()
            self.timerString = self.timeManager.displayTimer()
            self.totalTimerString = self.timeManager.runtimeToString(time: self.timeManager.runtime, second: true, japanease: false, onlyMin: false)
        }
        .sheet(isPresented: $showFontListView) {
            FontListView()
                .presentationDetents([.fraction(0.4)])
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
                    
                    if portraitOrNotFlag {
                        Slider(value: self.$timeManager.timerFontSizePortrait, in: 40...300)
                            .padding(.trailing, 5)
                            .frame(width: 160)
                    } else {
                        Slider(value: self.$timeManager.timerFontSizeSide, in: 40...350)
                            .padding(.trailing, 5)
                            .frame(width: 160)
                    }
                    
                    
                    Button(action: {
                        let impactLight = UIImpactFeedbackGenerator(style: .light)
                        impactLight.impactOccurred()
                        
                        withAnimation {
                            self.showFontListView = true
                        }
                    }){
                        Text("Font")
                            .font(.subheadline)
                            .padding(.trailing, 5)
                    }
                    
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
            .padding(.top, portraitOrNotFlag ? 50 : 30)
            .padding(.trailing, 20)

            Spacer()
        }
    }
    
    // FontをFontの名前から返す。等間隔フォントのみ特殊なフォントなため、条件分岐。
    private func returnFont(fontName: String, fontSize: CGFloat) -> Font {
        if fontName == "monospace" {
            let font = Font(UIFont.monospacedDigitSystemFont(ofSize: fontSize, weight: .medium))
            return font
        } else {
            let font = Font(UIFont(name: fontName, size: fontSize)!)
            return font
        }
    }
    
    // 画面の向きによって変化させる変数を更新
    private func updateOrientation() {
        portraitOrNotFlag = self.timeManager.returnOrientation()
        // 初回アプリ立ち上げ時にUserDefaultにデータがない状態でフォントサイズをロードすると、めちゃくちゃ小さくなってしまうから、更新。
        if self.timeManager.timerFontSizePortrait < 40 || self.timeManager.timerFontSizeSide < 40 {
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
            
            // オートリフレッシュOFFの場合は、タップ後、数秒後にボタンを非表示にする
            withAnimation {
                self.showFloatingItems = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                // 何も編集中ではない場合
                if !self.timeManager.timerShowSlider && !showFontListView {
                    withAnimation {
                        self.showFloatingItems = false
                    }
                }
            }
            
        } else {
            withAnimation {
                // 画面上部のボタンを表示非表示する（オートリフレッシュの場合のみ）
                self.showFloatingItems.toggle()
            }
        }
        
        withAnimation {
            // スライダーを非表示にする
            self.timeManager.timerShowSlider = false
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
            .environmentObject(TimeManager())

    }
}
