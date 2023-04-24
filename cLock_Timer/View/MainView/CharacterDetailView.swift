//
//  CharacterDetailView.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/03/28.
//

import SwiftUI


struct CharacterDetailView: View {
    @EnvironmentObject var timeManager: TimeManager
    @Environment(\.dismiss) var dismiss

    @State private var circleDiameter: CGFloat = 70
    
    @State private var imageSize: CGFloat = 200
    //　表示中のキャラクターの進化形態一覧のタップされたインデックス
    @State var tappedImageIndex: Int = -1
    //　所持キャラクターの最初の卵一覧のタップされたインデックス
    @State var tappedPossessionIndex: Int = -1
    //　未所持キャラクターの最初の卵一覧のタップされたインデックス
    @State var tappedNotPossessionIndex: Int = -1
    //　キャラクターを取り替えるかの確認アラートを表示
    @State var showChangeCharacterAlert = false
    //　画像を保存するかの確認アラートを表示
    @State var showSaveImageAlert = false
    //　ウィジェットへ追加するかの確認アラートを表示
    @State var showSetWidgetCharacterAlert = false
    // キャラクター育成詳細画面を表示
    @State var showCharacterQuestionView = false
    // キャラクター詳細画面に表示中のキャラクターを育成する
    @State var showSelectGrowCharacterAlert = false
    // 円形キャライメージの影
    @State var shadowX: CGFloat = 0
    @State var shadowY: CGFloat = 8
    @State var shadowRadius: CGFloat = 3
    @State var shadowDefalutColor: Color = .black
    @State var shadowSelectedColor: Color = .blue
    
    // 選択中のキャラクターが育成可能かどうかのフラグ
    @State var growAbleFlag: Bool = false
    // 選択中のキャラクターが、育成中のキャラクターと等しいかどうか
    @State var isSameSelectedCharacterFlag: Bool = false

    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    // 選択中のキャラクターの画像
                    selectedCharacterView
                        .padding(.horizontal, 20)

                    // 選択中のキャラクターの解放済み進化形態の一覧
                    selectedCharacterArray
                        .padding(.top, 10)
                    
                    // 選択中のキャラクターの解放状態がMAXの時にキャラクターの詳細を表示
                    characterDetailView
                        .padding(.top, 30)
                        .padding(.horizontal, 20)
                        .frame(height: 150)
                    
                    // 取得済みのキャラクターの一覧を表示
                    possessionCharacterList
                    
                    Spacer()
                }
                .padding(.top, 70)
                .padding(.bottom, 100)

            }
            
            // ボタン
            resetCharacterButton
        }
        .ignoresSafeArea()
        .sheet(isPresented: self.$showCharacterQuestionView) {
            CharacterQuestionView()
        }
        .onAppear {
            // 育成用ボタンの表示形式を更新
            growCharacterAbleFlag()
            // 現在表示中のキャラクターが現在育成中のキャラクターと同じか判別
            isSameSelectedCharacter()
        }
    }
    
    var selectedCharacterView: some View {
        VStack(spacing: 0) {
            if tappedImageIndex == -1 {
                Image(self.timeManager.phasesImageList[self.timeManager.phasesCount])
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 30)
                
                Text(self.timeManager.phasesNameList[self.timeManager.phasesCount])
                    .font(.title2.bold())
                    .frame(height: 80, alignment: .bottom)
                
            } else if tappedImageIndex < (self.timeManager.phasesCount + 1) {
                Image(self.timeManager.phasesImageList[tappedImageIndex])
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 30)
                
                Text(self.timeManager.phasesNameList[tappedImageIndex])
                    .font(.title2.bold())
                    .frame(height: 80, alignment: .bottom)
                
            } else {
                ZStack {
                    //　まだ解放していないキャラのシルエットのみ表示する
                    if tappedImageIndex == self.timeManager.phasesCount + 1 {
                        Image(self.timeManager.phasesImageList[tappedImageIndex])
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(Color.black)
                            .frame(width: imageSize, height: imageSize)
                    }
                    
                    Image("Question")
                        .resizable()
                        .frame(width: imageSize, height: imageSize)
                        .background(
                            Color(UIColor.systemGray)
                                .cornerRadius(imageSize)
                                .shadow(radius: 3, x: 0, y: 7)
                                .opacity(0.5)
                        )
                        .opacity(0.5)
                }
                
                Text("???")
                    .font(.title2.bold())
                    .frame(height: 80, alignment: .bottom)
            }
        }
    }
    
    // 選択中のキャラクターの一覧
    var selectedCharacterArray: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(0 ..< self.timeManager.phasesCount + 1, id: \.self) { num in
                    Image(self.timeManager.phasesImageList[num])
                        .resizable()
                        .frame(width: circleDiameter, height: circleDiameter)
                        .cornerRadius(circleDiameter)
                        .background(
                            Color(UIColor.systemGray6)
                                .cornerRadius(circleDiameter)
                                .shadow(color: num == tappedImageIndex ? shadowSelectedColor : shadowDefalutColor, radius: shadowRadius, x: shadowX, y: shadowY)
                                .opacity(0.5)
                        )
                        .padding(5)
                        .padding(.leading, num == 0 ? 30 : 0)
                        .onTapGesture {
                            let impactLight = UIImpactFeedbackGenerator(style: .light)
                            impactLight.impactOccurred()
                            withAnimation {
                                tappedImageIndex = num
                            }
                        }

                }
                ForEach(0 ..< (self.timeManager.phasesImageList.count - self.timeManager.phasesCount - 1), id: \.self) { num in
                    ZStack {
                        if num + self.timeManager.phasesCount + 1 == self.timeManager.phasesCount + 1 {
                            Image(self.timeManager.phasesImageList[num + self.timeManager.phasesCount + 1])
                                .renderingMode(.template)
                                .resizable()
                                .foregroundColor(Color.black)
                                .frame(width: circleDiameter, height: circleDiameter)
                                .cornerRadius(circleDiameter)
                        }
                        
                        Image("Question")
                            .resizable()
                            .frame(width: circleDiameter, height: circleDiameter)
                            .cornerRadius(circleDiameter)
                            .background(
                                Color(UIColor.systemGray)
                                    .cornerRadius(circleDiameter)
                                    .shadow(color: num + self.timeManager.phasesCount + 1 == tappedImageIndex ? shadowSelectedColor : shadowDefalutColor, radius: shadowRadius, x: shadowX, y: shadowY)
                                    .opacity(0.75)
                            )
                            .padding(5)
                            .onTapGesture {
                                let impactLight = UIImpactFeedbackGenerator(style: .light)
                                impactLight.impactOccurred()
                                withAnimation {
                                    tappedImageIndex = num + self.timeManager.phasesCount + 1
                                }
                            }
                            .opacity(0.75)
                    }
                }
                Spacer()
            }
            .frame(height: circleDiameter + 30)

        }
    }
    
    // キャラクターの説明文
    var characterDetailView: some View {
        ScrollView(.vertical) {
            if tappedImageIndex == -1 {
                Text(self.timeManager.selectedCharacterDetail[self.timeManager.phasesCount])
                    .font(.callout.bold())
                
            } else if tappedImageIndex < (self.timeManager.phasesCount + 1) {
                Text(self.timeManager.selectedCharacterDetail[tappedImageIndex])
                    .font(.callout.bold())
                
            } else {
                Text("???")
                    .font(.callout.bold())
            }
        }
    }
    
    var possessionCharacterList: some View {
        VStack(spacing: 0) {
            if self.timeManager.firstEggImageList.count != 0 {
                Text("獲得済みのキャラ \(self.timeManager.firstEggImageList.count)種")
                    .font(.title3.bold())
                    .padding(.top, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(0 ..< self.timeManager.firstEggImageList.count, id: \.self) { num in
                            Image(self.timeManager.firstEggImageList[num][1])
                                .resizable()
                                .frame(width: circleDiameter, height: circleDiameter)
                                .cornerRadius(circleDiameter)
                                .background(
                                    Color(UIColor.systemGray6)
                                        .cornerRadius(circleDiameter)
                                        .shadow(color: num == tappedPossessionIndex ? shadowSelectedColor : shadowDefalutColor, radius: shadowRadius, x: shadowX, y: shadowY)
                                        .opacity(0.5)
                                )
                                .padding(5)
                                .padding(.leading, num == 0 ? 30 : 0)
                                .onTapGesture {
                                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                                    impactLight.impactOccurred()
                                    withAnimation {
                                        tappedPossessionIndex = num
                                        self.timeManager.loadCharacterDetailData(selectedDetailCharacter: self.timeManager.firstEggImageList[num][0])
                                        // 育成用ボタンの表示形式を更新
                                        growCharacterAbleFlag()
                                        // 現在表示中のキャラクターが現在育成中のキャラクターと同じか判別
                                        isSameSelectedCharacter()
                                    }
                                }
                        }
                        
                        Spacer()
                    }
                    .frame(height: circleDiameter + 30)
                }
                .padding(.top, 20)
                
            }
            
            if self.timeManager.firstEggImageList.count < CharacterData.count {
                Text("未獲得のキャラ \(CharacterData.count - self.timeManager.firstEggImageList.count)種")
                    .font(.title3.bold())
                    .padding(.top, 40)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(0 ..< CharacterData.count - self.timeManager.firstEggImageList.count, id: \.self) { num in
                            Image("Question")
                                .resizable()
                                .frame(width: circleDiameter, height: circleDiameter)
                                .cornerRadius(circleDiameter)
                                .background(
                                    Color(UIColor.systemGray)
                                        .cornerRadius(circleDiameter)
                                        .shadow(color: num == tappedNotPossessionIndex ? shadowSelectedColor : shadowDefalutColor, radius: shadowRadius, x: shadowX, y: shadowY)

                                        .opacity(0.5)
                                )
                                .padding(.leading, num == 0 ? 30 : 0)
                                .padding(5)
                                .onTapGesture {
                                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                                    impactLight.impactOccurred()
                                    withAnimation {
                                        tappedNotPossessionIndex = num
                                    }
                                }
                        }
                        
                        Spacer()
                    }
                    .frame(height: circleDiameter + 30)
                }
                .padding(.top, 20)
            }
        }
    }
    
    var resetCharacterButton: some View {
        VStack {
            HStack {
                VStack {
                    Button(action: {
                        let impactLight = UIImpactFeedbackGenerator(style: .light)
                        impactLight.impactOccurred()

                        showCharacterQuestionView = true
                    }){
                        Image(systemName: "questionmark.circle")
                            .font(.title)
                    }

                    Spacer()
                }
                .padding(.top, 80)
                .padding(.leading, 20)
                
                Spacer()
                
                VStack(spacing: 15) {
                    VStack(spacing: 2) {
                        // Widget設定ボタン
                        Button(action: {
                            let impactLight = UIImpactFeedbackGenerator(style: .light)
                            impactLight.impactOccurred()
                            showSetWidgetCharacterAlert = true
                        }){
                            Image(systemName: "plus.app")
                                .font(.title)
                        }
                        .alert(isPresented: $showSetWidgetCharacterAlert) {
                            Alert(
                                title: Text("待受キャラにする"),
                                message: Text("現在選択中のキャラクターの画像をWidgetに表示します。"),
                                primaryButton: .cancel(Text("キャンセル")),
                                secondaryButton: .default(Text("設定する"), action: {
                                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                                    impactLight.impactOccurred()
                                    // 表示中の画像を保存する
                                    if tappedImageIndex == -1 {
                                        // キャラクター名
                                        self.timeManager.selectedWidgetCharacterName = self.timeManager.phasesNameList[self.timeManager.phasesCount]
                                        // キャラクターの画像の名前
                                        self.timeManager.selectedWidgetCharacterImageName = self.timeManager.phasesImageList[self.timeManager.phasesCount]
                                        
                                    } else if tappedImageIndex < (self.timeManager.phasesCount + 1) {
                                        // キャラクター名
                                        self.timeManager.selectedWidgetCharacterName = self.timeManager.phasesNameList[tappedImageIndex]
                                        // キャラクターの画像の名前
                                        self.timeManager.selectedWidgetCharacterImageName = self.timeManager.phasesImageList[tappedImageIndex]
                                        
                                    } else {
                                        // キャラクター名
                                        self.timeManager.selectedWidgetCharacterName = "???"
                                        // キャラクターの画像の名前
                                        self.timeManager.selectedWidgetCharacterImageName = "Question"
                                    }
                                    
                                    // アラームを閉じる
                                    showSetWidgetCharacterAlert = false
                                }))
                        }
                        
                        Text("Widget")
                            .font(.system(size: 10, weight: .regular, design: .default))
                    }
                    
                    // 表示中のキャラクターを育成対象に変更する
                    VStack(spacing: 2) {
                        Button(action: {
                            if growAbleFlag {
                                let impactLight = UIImpactFeedbackGenerator(style: .light)
                                impactLight.impactOccurred()
                                showSelectGrowCharacterAlert = true
                            }
                        }){
                            Image(systemName: "dumbbell")
                                .font(.title)
                        }
                        .alert(isPresented: $showSelectGrowCharacterAlert) {
                            Alert(
                                title: Text("このキャラを育成する"),
                                message: isSameSelectedCharacterFlag ? Text("ポイント使用画面へ移動して、このキャラクターを育成します。") : Text("現在育成中のキャラクターの育成を中断し、このキャラクターの育成を開始します。"),
                                primaryButton: .cancel(Text("キャンセル")),
                                secondaryButton: .default(Text("育成する"), action: {
                                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                                    impactLight.impactOccurred()
                                    
                                    withAnimation {
                                        // 表示中のキャラクターを育成対象に変更する
                                        if !isSameSelectedCharacterFlag {
                                            self.timeManager.expTime = 0
                                        }
                                        
                                        self.timeManager.selectedCharacter = self.timeManager.selectedDetailCharacterName
                                        self.timeManager.loadSelectedCharacterData()
                                        
                                        // ポイント画面へ移動する
                                        self.timeManager.selectTabIndex = 3
                                    }
                                    // アラームを閉じる
                                    showSelectGrowCharacterAlert = false
                                    dismiss()
                                }))
                        }
                        .foregroundColor(isSameSelectedCharacterFlag ? Color.green : Color.blue)
                        
                        Text("育成する")
                            .font(.system(size: 10, weight: .regular, design: .default))
                    }
                    .opacity(growAbleFlag ? 1.0 : 0.1)

                    Spacer()
                }
                .padding(.top, 80)
                .padding(.trailing, 20)

            }
            
            Spacer()
        }
    }
    
    // 現在選択中のキャラクターを育成できるかどうかの確認
    private func growCharacterAbleFlag() {
        // 現在表示中のキャラクターが最終形態まで育成されていなければTrue
        if self.timeManager.phasesCount < self.timeManager.phasesNameList.count - 1 {
            growAbleFlag = true
        } else {
            growAbleFlag = false
        }
    }
    
    // 現在選択中のキャラクターが現在育成中のキャラクターか確認
    private func isSameSelectedCharacter() {
        if self.timeManager.selectedCharacter == self.timeManager.selectedDetailCharacterName {
            isSameSelectedCharacterFlag = true
        } else {
            isSameSelectedCharacterFlag = false
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView()
            .environmentObject(TimeManager())
    }
}
