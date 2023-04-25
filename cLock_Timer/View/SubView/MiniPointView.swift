//
//  MiniPointView.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/04/25.
//

import SwiftUI

struct MiniPointView: View {
    @EnvironmentObject var timeManager: TimeManager
    @Environment(\.dismiss) var dismiss
    
    // Circle
    @State private var circleBackgroundUnusableColor: Color = Color(UIColor.label).opacity(0.3)
    @State private var circleBackgroundUsableColor: Color = Color.blue.opacity(0.7)
    @State private var circleDiameter: CGFloat = 30
    @State private var circleImageColor: Color = Color(UIColor.systemGray6)
    @State private var circleImagePadding: CGFloat = 9
    
    // Text
    @State private var selectTextColor: Color = Color(UIColor.label).opacity(0.7)
    @State private var usePointTextColor: Color = Color(UIColor.systemGray2)
    
    // Button
    @State private var buttonShadowColor: Color = Color(UIColor.black).opacity(0.2)
    @State private var buttonShadowRadius: CGFloat = 5
    
    // ポイント関連変数
    @State private var remainAllExpPoint: Int = 0
    @State private var remainExpPoint: Int = 0
    
    // Flags
    @State private var useAllPointFlag: Bool = false
    @State private var usePointNextPhaseFlag: Bool = false
    @State private var gachaAbleFlag: Bool = false
    
    // Alart Flag
    @State private var showUseAllPointAlartFlag: Bool = false
    @State private var showUsePointForNextPhaseAlartFlag: Bool = false
    @State private var showGachaAlartFlag: Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                titleView
                
                growCharacterView
                
                gachaView
                
                Spacer()
            }
            .padding(.top, 10)
        }
        .ignoresSafeArea()
        .padding(.horizontal, 10)
        .background(
            Color(UIColor.systemGray6)
        )
        .onAppear {
            self.timeManager.timerStatus = .stopped
            
            updatePointData()
        }
        .onDisappear {
            if self.timeManager.selectTabIndex == 1 {
                self.timeManager.start()
            }
        }
    }
    
    var titleView: some View {
        VStack(spacing: 20) {
            HStack {
                Text("保有ポイント　\(Int(self.timeManager.eggPoint)) Pt")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }){
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .foregroundColor(Color.gray)
                        .frame(width: circleDiameter, height: circleDiameter)
                }
            }
        }
    }
    
    var growCharacterView: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "dumbbell")
                
                Text("育成")
                
                Spacer()
            }
            
            Button(action: {
                self.showUseAllPointAlartFlag = true
            }){
                ZStack {
                    HStack {
                        Image(systemName: "arrowshape.bounce.right")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(circleImageColor)
                            .frame(width: circleDiameter, height: circleDiameter)
                            .padding(circleImagePadding)
                            .background(
                                useAllPointFlag ? circleBackgroundUsableColor.cornerRadius(circleDiameter) : circleBackgroundUnusableColor.cornerRadius(circleDiameter)
                            )
                        Text("全てのポイントを利用する")
                            .foregroundColor(selectTextColor)
                            .font(.subheadline)
                        Spacer()
                        
                        Text("\(remainAllExpPoint) Pt")
                            .font(.subheadline)
                            .foregroundColor(usePointTextColor)
                    }
                    .padding(5)
                }
            }
            .disabled(!useAllPointFlag)
            .background(
                Color(UIColor.systemBackground)
                    .cornerRadius(10)
                    .shadow(color: useAllPointFlag ? buttonShadowColor : .clear, radius: buttonShadowRadius, x: 0, y: 2)
            )
            .alert(isPresented: $showUseAllPointAlartFlag) {
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
                        showUseAllPointAlartFlag = false
                    }))
            }
            
            Button(action: {
                self.showUsePointForNextPhaseAlartFlag = true
            }){
                ZStack {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.right")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(circleImageColor)
                            .frame(width: circleDiameter, height: circleDiameter)
                            .padding(circleImagePadding)
                            .background(
                                usePointNextPhaseFlag ? circleBackgroundUsableColor.cornerRadius(circleDiameter) : circleBackgroundUnusableColor.cornerRadius(circleDiameter)
                            )
                        Text("次の形態まで進化させる")
                            .font(.subheadline)
                            .foregroundColor(selectTextColor)
                        Spacer()
                        Text("\(remainExpPoint) Pt")
                            .font(.subheadline)
                            .foregroundColor(usePointTextColor)
                    }
                    .padding(5)
                }
            }
            .disabled(!usePointNextPhaseFlag)
            .background(
                Color(UIColor.systemBackground)
                    .cornerRadius(10)
                    .shadow(color: usePointNextPhaseFlag ? buttonShadowColor : .clear, radius: buttonShadowRadius, x: 0, y: 2)
            )
            .alert(isPresented: $showUsePointForNextPhaseAlartFlag) {
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
                        showUsePointForNextPhaseAlartFlag = false
                    }))
            }
        }
        .padding(.horizontal, 10)
    }
    
    var gachaView: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "hare")
                
                Text("ガチャ")
                
                Spacer()
                
                Text("未所持: \(CharacterData.count - self.timeManager.firstEggImageList.count)種")
                    .font(.system(size: 15))
                    .foregroundColor(Color(UIColor.systemGray2))
                    .bold()
            }
            
            Button(action: {
                self.showGachaAlartFlag = true
            }){
                ZStack {
                    HStack {
                        Image(systemName: "tray.and.arrow.down.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(circleImageColor)
                            .frame(width: circleDiameter, height: circleDiameter)
                            .padding(circleImagePadding)
                            .background(
                                gachaAbleFlag ? circleBackgroundUsableColor.cornerRadius(circleDiameter) : circleBackgroundUnusableColor.cornerRadius(circleDiameter)
                            )
                        Text("ガチャを引く")
                            .font(.subheadline)
                            .foregroundColor(selectTextColor)
                        Spacer()
                        Text(self.timeManager.gachaOneDayFlag ? "\(self.timeManager.gachaPoint) Pt" : "0 Pt")
                            .font(.subheadline)
                            .foregroundColor(usePointTextColor)
                    }
                    .padding(5)
                }
            }
            .disabled(!gachaAbleFlag)
            .background(
                Color(UIColor.systemBackground)
                    .cornerRadius(10)
                    .shadow(color: gachaAbleFlag ? buttonShadowColor : .clear, radius: buttonShadowRadius, x: 0, y: 2)
            )
            .alert(isPresented: $showGachaAlartFlag) {
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
        }
        .padding(.horizontal, 10)
    }
    
    // MARK: - 画面制御関連
    // ポイントに関するデータを更新する
    private func updatePointData() {
        self.timeManager.gachaPoint = self.timeManager.gachaDefaultPoint + 1000 * self.timeManager.gachaCountOneDay
        
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
        showGachaAlartFlag = false
    }
}

struct MiniPointView_Previews: PreviewProvider {
    static var previews: some View {
        MiniPointView()
            .environmentObject(TimeManager())

    }
}
