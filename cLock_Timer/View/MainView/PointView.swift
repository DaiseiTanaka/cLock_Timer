//
//  PointView.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/04/17.
//

import SwiftUI

struct PointView: View {
    @EnvironmentObject var timeManager: TimeManager
    @Environment(\.dismiss) var dismiss
    
    // Font
    @State private var titleFontSize: CGFloat = 25
    @State private var subTitleFontSize: CGFloat = 17
    
    // Image
    @State private var imageSize: CGFloat = 100
    
    // Button
    @State private var buttonTextColor: Color = Color.white
    @State private var buttonTextSize: CGFloat = 12
    @State private var buttonBackgroundColorAble: Color = Color.green.opacity(0.7)
    @State private var buttonBackgroundColorDisable: Color = Color(UIColor.systemGray6)
    @State private var buttonShadowColor: Color = Color(UIColor.black).opacity(0.2)
    @State private var buttonShadowRadius: CGFloat = 5
    @State private var buttonShadowY: CGFloat = 2
    
    @State private var viewShadowColor: Color = Color(UIColor.black).opacity(0.15)
    @State private var viewShadowRadius: CGFloat = 10
    @State private var viewShadowY: CGFloat = 5
    
    @State private var eggPoint: Int = 0
    @State private var remainAllExpPoint: Int = 0
    @State private var remainExpPoint: Int = 0
    
    // Flags
    @State private var useAllPointFlag: Bool = false
    @State private var usePointNextPhaseFlag: Bool = false
    @State private var gachaAbleFlag: Bool = false
    @State private var showCharacterDetailView: Bool = false
    
    // Alart iPhoneの時はダイアログを表示し、iPadの時はアラートを表示する
    /// for iPhone
    @State private var showUseAllPointDialogPhone: Bool = false
    @State private var showUsePointForNextPhaseDialogPhone: Bool = false
    @State private var showGachaDialogPhone: Bool = false
    /// for iPad
    @State private var showUseAllPointDialogPad: Bool = false
    @State private var showUsePointForNextPhaseDialogPad: Bool = false
    @State private var showGachaDialogPad: Bool = false
    
    // 画面の向きを制御
    @State var orientation: UIDeviceOrientation
    @State var portraitOrNotFlag: Bool = true
    
    init() {
        self._orientation = State(wrappedValue: UIDevice.current.orientation)
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 40) {
                pointTitleView
                
                pointGrowCharacterView
                
                pointGachaView
                
                Spacer()
            }
            .padding(.top, portraitOrNotFlag ? 60 : 20)
            .padding(.bottom, 70)
            .padding(.horizontal, portraitOrNotFlag ? 10 : 40)
        }
        .ignoresSafeArea()
        .background(
            Color(UIColor.systemGray6)
        )
        .onAppear {
            self.timeManager.timerStatus = .stopped
            self.timeManager.gachaPoint = self.timeManager.gachaDefaultPoint + 1000 * self.timeManager.gachaCountOneDay
            updatePointData()
        }
        .onDisappear {
            if self.timeManager.selectTabIndex == 1 {
                self.timeManager.start()
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
        .sheet(isPresented: $showCharacterDetailView) {
            CharacterDetailView()
                .presentationDetents([.large])
        }
        // 全てのポイントを利用
        .confirmationDialog("全てのポイントを利用する", isPresented: $showUseAllPointDialogPhone, titleVisibility: .visible) {
            Button("育成する") {
                let impactLight = UIImpactFeedbackGenerator(style: .light)
                impactLight.impactOccurred()
                
                withAnimation {
                    self.timeManager.expTime += Double(remainAllExpPoint) + 1
                    self.timeManager.eggPoint -= remainAllExpPoint
                    updatePointData()
                }
            }
        } message: {
            Text("\(remainAllExpPoint)Ptを利用してキャラクターを育成します。")
        }
        // 次の形態まで進化
        .confirmationDialog("キャラクターを次の形態まで進化させる", isPresented: $showUsePointForNextPhaseDialogPhone, titleVisibility: .visible) {
            Button("進化させる") {
                let impactLight = UIImpactFeedbackGenerator(style: .light)
                impactLight.impactOccurred()
                
                withAnimation {
                    self.timeManager.expTime += Double(remainExpPoint) + 1
                    self.timeManager.eggPoint -= remainExpPoint
                    
                    updatePointData()
                }
            }
        } message: {
            Text("\(remainExpPoint)Ptを利用してキャラクターを進化させます。")
        }
        
        // ガチャ
        .confirmationDialog("Eggいガチャ", isPresented: $showGachaDialogPhone, titleVisibility: .visible) {
            Button("Eggいガチャを引く") {
                let impactLight = UIImpactFeedbackGenerator(style: .light)
                impactLight.impactOccurred()
                
                gachaFunction()
            }
        } message: {
            if self.timeManager.gachaOneDayFlag {
                Text("\(self.timeManager.gachaPoint)Ptを利用して未所持のキャラを取得します。")
            } else {
                Text("0Ptを利用して未所持のキャラを取得します。(毎日１回無料)")
            }
        }
        
    }
    
    // MARK: - 画面関連
    var pointTitleView: some View {
        VStack(spacing: 15) {
            // タイトル
            HStack {
                Spacer()
                Text("Eggいポイントを利用する")
                    .font(.system(size: titleFontSize, weight: .heavy, design: .rounded))
                Spacer()
            }
            
            VStack(spacing: 5) {
                HStack {
                    Text("保有ポイント")
                        .font(.system(size: 15))
                        .foregroundColor(Color(UIColor.systemGray2))
                    Spacer()
                }
                .padding(.leading, 30)
                
                HStack {
                    Spacer()
                    Text("\(Int(self.timeManager.eggPoint)) Pt")
                        .font(.system(size: 20))
                        .foregroundColor(Color(UIColor.systemGray))
                        .padding(.vertical, 15)
                        .bold()
                    Spacer()
                }
                .background(Color(UIColor.systemBackground).cornerRadius(10).padding(.horizontal, 10))
            }
        }
    }
    
    var pointGrowCharacterView: some View {
        VStack(spacing: 15) {
            HStack(spacing: 5) {
                Image(systemName: "dumbbell")
                    .font(.body)
                    .padding(.leading, 10)
                Text("キャラクターを育成する")
                    .font(.system(size: subTitleFontSize, weight: .bold, design: .rounded))
                Spacer()
            }
            
            VStack(spacing: 15) {
                characterImageDefault
                    .padding(.top, 15)
                
                HStack(spacing: 20) {
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        if UIDevice.current.userInterfaceIdiom == .phone {
                            showUseAllPointDialogPhone = true
                        }
                        if UIDevice.current.userInterfaceIdiom == .pad {
                            showUseAllPointDialogPad = true
                        }
                    }){
                        VStack(spacing: 3) {
                            Text("全てのポイントを利用する")
                                .font(.system(size: buttonTextSize, weight: .bold, design: .rounded))
                                .foregroundColor(self.buttonTextColor)
                            Text("-\(remainAllExpPoint) Pt")
                                .font(.system(size: buttonTextSize, weight: .heavy, design: .rounded))
                                .foregroundColor(self.buttonTextColor)
                        }
                    }
                    .disabled(!useAllPointFlag)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 10)
                    .background(useAllPointFlag ? self.buttonBackgroundColorAble : self.buttonBackgroundColorDisable)
                    .cornerRadius(20)
                    .shadow(color: useAllPointFlag ? buttonShadowColor : .clear, radius: buttonShadowRadius, x: 0, y: buttonShadowY)
                    .alert(isPresented: $showUseAllPointDialogPad) {
                        Alert(
                            title: Text("全てのポイントを利用する"),
                            message: Text("\(remainAllExpPoint) Ptを利用してキャラクターを育成します。"),
                            primaryButton: .cancel(Text("キャンセル")),
                            secondaryButton: .default(Text("育成する"), action: {
                                let impactLight = UIImpactFeedbackGenerator(style: .light)
                                impactLight.impactOccurred()
                                
                                withAnimation {
                                    self.timeManager.expTime += Double(remainAllExpPoint) + 1
                                    self.timeManager.eggPoint -= remainAllExpPoint
                                    updatePointData()
                                }
                                // アラームを閉じる
                                showUseAllPointDialogPad = false
                            }))
                    }
                    
                    Button(action: {
                        if UIDevice.current.userInterfaceIdiom == .phone {
                            showUsePointForNextPhaseDialogPhone = true
                        }
                        if UIDevice.current.userInterfaceIdiom == .pad {
                            showUsePointForNextPhaseDialogPad = true
                        }
                    }){
                        VStack(spacing: 3) {
                            Text("次の形態まで進化させる ")
                                .font(.system(size: buttonTextSize, weight: .bold, design: .rounded))
                                .foregroundColor(self.buttonTextColor)
                            Text("-\(remainExpPoint) Pt")
                                .font(.system(size: buttonTextSize, weight: .heavy, design: .rounded))
                                .foregroundColor(self.buttonTextColor)
                        }
                    }
                    .disabled(!usePointNextPhaseFlag)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 10)
                    .background(usePointNextPhaseFlag ? self.buttonBackgroundColorAble : self.buttonBackgroundColorDisable)
                    .cornerRadius(20)
                    .shadow(color: usePointNextPhaseFlag ? buttonShadowColor : .clear, radius: buttonShadowRadius, x: 0, y: buttonShadowY)
                    .alert(isPresented: $showUsePointForNextPhaseDialogPad) {
                        Alert(
                            title: Text("キャラクターを次の形態まで進化させる"),
                            message: Text("\(remainExpPoint) Ptを利用してキャラクターを進化させます。"),
                            primaryButton: .cancel(Text("キャンセル")),
                            secondaryButton: .default(Text("進化させる"), action: {
                                let impactLight = UIImpactFeedbackGenerator(style: .light)
                                impactLight.impactOccurred()
                                
                                withAnimation {
                                    self.timeManager.expTime += Double(remainExpPoint) + 1
                                    self.timeManager.eggPoint -= remainExpPoint
                                    updatePointData()
                                }
                                // アラームを閉じる
                                showUsePointForNextPhaseDialogPad = false
                            }))
                    }
                    
                    Spacer(minLength: 0)
                }
                .padding(.bottom, 10)

            }
            .background(
                Color(UIColor.systemBackground)
                    .cornerRadius(20)
                    .padding(.horizontal, 10)
                    .shadow(color: viewShadowColor, radius: viewShadowRadius, x: 0, y: viewShadowY)
            )
        }
    }
    
    var characterImageDefault: some View {
        ZStack {
            Circle()
                .trim(from: 0.01, to: returnGrowCircleRatio() - 0.01)
                .stroke(Color.blue.opacity(0.5), style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                .scaledToFit()
                .rotationEffect(Angle(degrees: -90))
            Circle()
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                .scaledToFit()
                .opacity(0.1)
            Image(self.timeManager.selectedCharacterImageName)
                .resizable()
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 20)
                .padding(10)
                .onTapGesture {
                    // キャラクター詳細画面を表示
                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                    impactLight.impactOccurred()
                    self.timeManager.loadCharacterDetailData(selectedDetailCharacter: self.timeManager.selectedCharacter)
                    
                    showCharacterDetailView.toggle()
                }
            
        }
        .frame(width: returnImageSize(), height: returnImageSize())
    }
    
    var characterImageTest: some View {
        ZStack {
            VStack {
                Spacer()
                ZStack {
                    Ellipse()
                    //Circle()
                        .trim(from: 0.01, to: returnGrowCircleRatio())
                    
                        .stroke(Color.blue.opacity(0.5), style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                        .frame(width: returnImageSize()/3, height: returnImageSize())
                    
                    //.scaledToFill()
                        .rotationEffect(Angle(degrees: -90))
                    //Circle()
                    Ellipse()
                        .trim(from: 0.01, to: 0.99)
                        .stroke(Color.blue, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                        .frame(width: returnImageSize()/3, height: returnImageSize())
                    //.scaledToFill()
                        .rotationEffect(Angle(degrees: -90))
                        .opacity(0.1)
                    
                    Image(self.timeManager.selectedCharacterImageName)
                        .renderingMode(.template)
                        .resizable()
                        .foregroundColor(.black.opacity(0.2))
                        .frame(width: returnImageSize()*0.7, height: returnImageSize()*0.7/3)
                        .shadow(color: .black, radius: 10)
                        .padding(.bottom, 20)
                        //.padding(.leading, 30)
                }
                .frame(width: returnImageSize(), height: returnImageSize()/2.5)

            }
            
            Image(self.timeManager.selectedCharacterImageName)
                .resizable()
                //.shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 15)
                //.shadow(color: .black.opacity(0.5), radius: 0.4, x: 0, y: 65)
                .padding()
                .onTapGesture {
                    // キャラクター詳細画面を表示
                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                    impactLight.impactOccurred()
                    self.timeManager.loadCharacterDetailData(selectedDetailCharacter: self.timeManager.selectedCharacter)
                    
                    showCharacterDetailView.toggle()
                }
                .frame(width: returnImageSize(), height: returnImageSize())

        }
        .frame(width: returnImageSize(), height: returnImageSize()*1.33)
    }
    
    var pointGachaView: some View {
        VStack(spacing: 15) {
            VStack(spacing: 5) {
                HStack {
                    Image(systemName: "hare")
                        .font(.body)
                        .padding(.leading, 10)
                    Text("Eggいガチャ")
                        .font(.system(size: subTitleFontSize, weight: .bold, design: .rounded))
                    Spacer()
                }
                HStack {
                    Text("ポイントを利用して未所持のタマゴを獲得する")
                        .font(.system(size: 14))
                        .foregroundColor(Color(UIColor.systemGray2))
                        .padding(.leading, 30)
                    Spacer()
                }
            }
            
            HStack {
                Spacer()
                Text("残り")
                    .font(.system(size: 15))
                    .foregroundColor(Color(UIColor.systemGray3))
                Text("\(CharacterData.count - self.timeManager.firstEggImageList.count)種")
                    .font(.system(size: 15))
                    .foregroundColor(Color(UIColor.systemGray2))
                    .bold()
            }
            .padding(.trailing, 20)
            
            HStack(spacing: 0) {
                Spacer(minLength: 0)
                
                Image("Question")
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 5)
                    .padding(10)
                
                Spacer(minLength: 0)
                
                Button(action: {
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        showGachaDialogPhone = true
                    }
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        showGachaDialogPad = true
                    }
                }){
                    VStack(spacing: 3) {
                        Text("Eggいガチャを回す")
                            .font(.system(size: buttonTextSize, weight: .bold, design: .rounded))
                            .foregroundColor(buttonTextColor)
                        Text(self.timeManager.gachaOneDayFlag ? "-\(self.timeManager.gachaPoint) Pt" : "-0 Pt")
                            .font(.system(size: buttonTextSize, weight: .heavy, design: .rounded))
                            .foregroundColor(buttonTextColor)
                    }
                }
                .disabled(!gachaAbleFlag)
                .padding(.horizontal, 7)
                .padding(.vertical, 10)
                .background(gachaAbleFlag ? self.buttonBackgroundColorAble : self.buttonBackgroundColorDisable)
                .cornerRadius(20)
                .shadow(color: gachaAbleFlag ? buttonShadowColor : .clear, radius: buttonShadowRadius, x: 0, y: buttonShadowY)
                .alert(isPresented: $showGachaDialogPad) {
                    Alert(
                        title: Text("Eggいガチャ"),
                        message: self.timeManager.gachaOneDayFlag ? Text("\(self.timeManager.gachaPoint)Ptを利用して未所持のキャラを取得します。") : Text("0Ptを利用して未所持のキャラを取得します。(毎日１回無料)"),
                        primaryButton: .cancel(Text("キャンセル")),
                        secondaryButton: .default(Text("ガチャを引く"), action: {
                            let impactLight = UIImpactFeedbackGenerator(style: .light)
                            impactLight.impactOccurred()
                            
                            gachaFunction()
                        }))
                }
                
                Spacer(minLength: 0)
            }
            
            .background(
                Color(UIColor.systemBackground)
                    .cornerRadius(20)
                    .padding(.horizontal, 10)
                    .shadow(color: gachaAbleFlag ? viewShadowColor : .clear, radius: viewShadowRadius, x: 0, y: viewShadowY)
            )
        }
    }
    
    
    // MARK: - 画面制御関連
    // ポイントに関するデータを更新する
    private func updatePointData() {
        self.timeManager.loadSelectedCharacterData()
        self.timeManager.loadCharacterDetailData(selectedDetailCharacter: self.timeManager.selectedCharacter)
        
        // 消費するポイント数を更新
        calcRemainExpPoint()
        calcRemainAllExpPoint()
        // ボタンが押せるかどうか確認
        returnGrowCharacterButtonOpacityFlagAllPoint()
        returnGrowCharacterButtonOpacityFlag()
        returnGachaAbleFlag()
    }
    
    // 全てのポイントを利用してキャラを育成する時に必要なポイント数を返す
    private func calcRemainAllExpPoint() {
        let hp = self.timeManager.selectedCharacterHP
        let expTime = Int(self.timeManager.expTime)
        let eggPoint = self.timeManager.eggPoint
        let expRatio = self.timeManager.selectedCharacterExpRatio
        // 最終形態になるまでに必要な総ポイント数
        let finalHp = Int(hp * expRatio[expRatio.count - 1])
        // 最終形態になるまでに必要な残りポイント数
        let remainAllExpPoint = finalHp - expTime
        
        // 最終形態にまだなっていない場合
        if remainAllExpPoint > 0 {
            // 最終形態までの残りポイント数が、所持ポイント数以上の場合　-> 全ての所持ポイントを利用する
            if eggPoint <= remainAllExpPoint {
                self.remainAllExpPoint = eggPoint
                // 所持ポイントが、最終形態までのポイント数を超えている場合 -> 必要なポイント数のみ利用する
            } else {
                self.remainAllExpPoint = remainAllExpPoint
            }
            // すでに最終形態になっている場合
        } else {
            self.remainAllExpPoint = 0
        }
    }
    
    // キャラクターが次の形態まで進化するまでに必要なポイント数を返す
    private func calcRemainExpPoint() {
        let hp = self.timeManager.selectedCharacterHP
        let expTime = Int(self.timeManager.expTime)
        let expRatio = self.timeManager.selectedCharacterExpRatio
        let phaseCount = self.timeManager.selectedCharacterPhaseCount
        var pointOfNextPhase = 0
        // 次の形態になるまでに必要なポイント数
        var remainExpPoint = 0
        // まだ最終形態ではない場合
        if phaseCount < expRatio.count {
            pointOfNextPhase = Int(hp * expRatio[phaseCount])
            remainExpPoint = pointOfNextPhase - expTime
        } else {
            remainExpPoint = 0
        }
        
        self.remainExpPoint = remainExpPoint
    }
    
    // 全てのポイントを利用するボタン
    // キャラクター育成用ボタンの透明度を上げる -> trueを返す
    // true: キャラクターがまだ最終形態まで進化していない / ポイントが次の形態に進化する基準を超えている
    private func returnGrowCharacterButtonOpacityFlagAllPoint() {
        let expRatio = self.timeManager.selectedCharacterExpRatio
        let phaseCount = self.timeManager.selectedCharacterPhaseCount
        let eggPoint = self.timeManager.eggPoint
        
        if phaseCount < expRatio.count && eggPoint > 0 {
            useAllPointFlag = true
        } else {
            useAllPointFlag = false
        }
    }
    
    // 次の形態への進化用ボタン
    // キャラクター育成用ボタンの透明度を上げる -> trueを返す
    // true: キャラクターがまだ最終形態まで進化していない / ポイントが次の形態に進化する基準を超えている
    private func returnGrowCharacterButtonOpacityFlag() {
        let hp = self.timeManager.selectedCharacterHP
        let expTime = Int(self.timeManager.expTime)
        let eggPoint = self.timeManager.eggPoint
        let expRatio = self.timeManager.selectedCharacterExpRatio
        let phaseCount = self.timeManager.selectedCharacterPhaseCount
        var pointOfNextPhase = 0
        // 次の形態になるまでに必要なポイント数
        var remainExpPoint = 0
        // まだ最終形態ではない場合
        if phaseCount < expRatio.count {
            pointOfNextPhase = Int(hp * expRatio[phaseCount])
            remainExpPoint = pointOfNextPhase - expTime
        } else {
            remainExpPoint = 0
        }
        print("pointOfNextPhase: \(pointOfNextPhase), eggPoint: \(eggPoint)")
        if phaseCount < expRatio.count && remainExpPoint <= eggPoint {
            usePointNextPhaseFlag = true
        } else {
            usePointNextPhaseFlag = false
        }
    }
    
    // ガチャを引くためのボタンの押せるかどうかのFlag -> trueの時は引ける
    private func returnGachaAbleFlag() {
        // 所持ポイントがガチャに必要なポイント以上の時　＆　未所持キャラがある場合
        if self.timeManager.notPossessionList.count != 0 && self.timeManager.eggPoint >= self.timeManager.gachaPoint {
            gachaAbleFlag = true
            // この日初めてガチャを引く場合　＆　未所持キャラがある場合
        } else if self.timeManager.notPossessionList.count != 0 && !self.timeManager.gachaOneDayFlag {
            gachaAbleFlag = true
        } else {
            gachaAbleFlag = false
        }
    }
    
    // キャラクター育成状態の円グラフを表示
    private func returnGrowCircleRatio() -> Double{
        let hp = self.timeManager.selectedCharacterHP
        let expRatio = self.timeManager.selectedCharacterExpRatio
        let phaseCount = self.timeManager.selectedCharacterPhaseCount
        var thisPhaseHP = 0.0
        var nowExp = 0.0
        
        if phaseCount == 0 {
            thisPhaseHP = hp * expRatio[phaseCount]
            nowExp = self.timeManager.expTime
        } else if phaseCount == expRatio.count {
            thisPhaseHP = hp - hp * expRatio[phaseCount-1]
            nowExp = self.timeManager.expTime - hp * expRatio[phaseCount-1]
        } else {
            thisPhaseHP = hp * expRatio[phaseCount] - hp * expRatio[phaseCount-1]
            nowExp = self.timeManager.expTime - hp * expRatio[phaseCount-1]
        }
        
        let ratio = nowExp / thisPhaseHP
        //print("returnGrowRatio(): \n\(hp) \(expRatio) \(phaseCount) \(thisPhaseHP) \(nowExp) \(ratio)")
        return ratio
    }
    
    // ガチャを引いた瞬間に実行される関数
    private func gachaFunction() {
        // ガチャポイントを更新
        self.timeManager.gachaPoint = self.timeManager.gachaDefaultPoint + 1000 * self.timeManager.gachaCountOneDay
        self.timeManager.gachaCountOneDay += 1
        
        //　一日一回無料ガチャをすでに引いた場合、有料ガチャ
        if self.timeManager.gachaOneDayFlag {
            self.timeManager.eggPoint -= self.timeManager.gachaPoint
        }
        // 一日一回無料ガチャ
        self.timeManager.gachaOneDayFlag = true
        
        self.timeManager.showGachaView = true
        
        dismiss()
        withAnimation {
            updatePointData()
        }
        // アラームを閉じる
        showGachaDialogPad = false
    }
    
    private func returnImageSize() -> CGFloat {
        var imageSize: CGFloat = 0
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        
        let minLength: CGFloat = min(screenHeight, screenWidth)
        imageSize = minLength * 0.5
        
        return imageSize
    }
    
    private func returnMinScreenWidth() -> CGFloat {
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        
        let min: CGFloat = min(screenHeight, screenWidth)
        
        return min
    }
}

struct PointView_Previews: PreviewProvider {
    static var previews: some View {
        PointView()
            .environmentObject(TimeManager())
    }
}
