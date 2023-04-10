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

    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    // 選択中のキャラクターの画像
                    selectedCharacterView
                        .padding(.top, 70)
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
                .padding(.bottom, 50)

            }
            
            // ボタン
            resetCharacterButton
        }
        .sheet(isPresented: self.$showCharacterQuestionView) {
            CharacterQuestionView()
        }
    }
    
    var selectedCharacterView: some View {
        VStack(spacing: 0) {
            if tappedImageIndex == -1 {
                Image(self.timeManager.phasesImageList[self.timeManager.phasesCount])
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .shadow(color: .black.opacity(0.3), radius: 5)
                
                Text(self.timeManager.phasesNameList[self.timeManager.phasesCount])
                    .font(.title2.bold())
                    .frame(height: 80, alignment: .bottom)
                
            } else if tappedImageIndex < (self.timeManager.phasesCount + 1) {
                Image(self.timeManager.phasesImageList[tappedImageIndex])
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .shadow(color: .black.opacity(0.3), radius: 5)
                
                Text(self.timeManager.phasesNameList[tappedImageIndex])
                    .font(.title2.bold())
                    .frame(height: 80, alignment: .bottom)
                
            } else {
                ZStack {
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
                                .shadow(radius: 3)
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
                                .shadow(color: num == tappedImageIndex ? .blue : .black, radius: 3)
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
//                                .background(
//                                    Color(UIColor.systemGray6)
//                                        .cornerRadius(circleDiameter)
//                                        .shadow(color: num + self.timeManager.phasesCount + 1 == tappedImageIndex ? .blue : .black, radius: 3)
//                                        .opacity(0.5)
//                                )
                        }
                        
                        Image("Question")
                            .resizable()
                            .frame(width: circleDiameter, height: circleDiameter)
                            .cornerRadius(circleDiameter)
                            .background(
                                Color(UIColor.systemGray)
                                    .cornerRadius(circleDiameter)
                                    .shadow(color: num + self.timeManager.phasesCount + 1 == tappedImageIndex ? .blue : .black, radius: 3)
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
        }
    }
    
    // キャラクターの説明文
    var characterDetailView: some View {
        ScrollView(.vertical) {
            if tappedImageIndex == -1 {
//                Image(self.timeManager.phasesImageList[self.timeManager.phasesCount])
//                    .resizable()
//                    .frame(width: imageSize, height: imageSize)
//                    .shadow(color: .black.opacity(0.3), radius: 5)
//
//                Text(self.timeManager.phasesNameList[self.timeManager.phasesCount])
//                    .font(.title2.bold())
//                    .frame(height: 80, alignment: .bottom)
                
                Text(self.timeManager.selectedCharacterDetail[self.timeManager.phasesCount])
                    .font(.callout.bold())
                
            } else if tappedImageIndex < (self.timeManager.phasesCount + 1) {
//                Image(self.timeManager.phasesImageList[tappedImageIndex])
//                    .resizable()
//                    .frame(width: imageSize, height: imageSize)
//                    .shadow(color: .black.opacity(0.3), radius: 5)
//
//                Text(self.timeManager.phasesNameList[tappedImageIndex])
//                    .font(.title2.bold())
//                    .frame(height: 80, alignment: .bottom)
                
                Text(self.timeManager.selectedCharacterDetail[tappedImageIndex])
                    .font(.callout.bold())
                
            } else {
                Text("???")
                    .font(.callout.bold())
            }
            
//            if self.timeManager.phasesCount == self.timeManager.phasesImageList.count-1 {
//
//                Text(self.timeManager.selectedCharacterDetail)
//                    .font(.callout.bold())
//            } else {
//                Text("???")
//                    .font(.callout.bold())
//            }
        }
    }
    
    var possessionCharacterList: some View {
        VStack(spacing: 0) {
            if self.timeManager.firstEggImageList.count != 0 {
                Text("獲得済みのキャラ \(self.timeManager.firstEggImageList.count)種")
                    .font(.title3.bold())
                    //.padding(.top, 40)
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
                                        .shadow(color: num == tappedPossessionIndex ? .blue : .black, radius: 3)
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
                                    }
                                }
                        }
                        
                        Spacer()
                    }
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
                                        .shadow(color: num == tappedNotPossessionIndex ? .blue : .black, radius: 3)
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
                    // キャラクター入れ替えボタン
                    Button(action: {
                        // 未所持キャラがいる場合
                        if self.timeManager.notPossessionList.count != 0 {
                            let impactLight = UIImpactFeedbackGenerator(style: .light)
                            impactLight.impactOccurred()
                            
                            showChangeCharacterAlert = true
                        }
                    }){
                        Image(systemName: "arrow.counterclockwise.circle")
                            .font(.title)
                    }
                    .alert(isPresented: $showChangeCharacterAlert) {
                        Alert(
                            title: Text("タマゴを入れ替える"),
                            message: Text("現在育成中のキャラクターの育成は中断されます。"),
                            primaryButton: .cancel(Text("キャンセル")),
                            secondaryButton: .default(Text("入れ替える"), action: {
                                let impactLight = UIImpactFeedbackGenerator(style: .light)
                                impactLight.impactOccurred()
                                // キャラクターを入れ替える
                                withAnimation {
                                    self.timeManager.expTime = 0
                                    self.timeManager.selectedCharacter = self.timeManager.selectNewCharacter()
                                    self.timeManager.loadSelectedCharacterData()
                                    self.timeManager.loadCharacterDetailData(selectedDetailCharacter: self.timeManager.selectedCharacter)
                                }
                                showChangeCharacterAlert = false
                            })
                        )
                    }
                    .opacity(self.timeManager.notPossessionList.count != 0 ? 1.0 : 0.1)
                    .foregroundColor(self.timeManager.notPossessionList.count != 0 ? Color.blue : Color(UIColor.darkGray))
                    
                    
                    // 画像ダウンロードボタン
//                    Button(action: {
//                        let impactLight = UIImpactFeedbackGenerator(style: .light)
//                        impactLight.impactOccurred()
//                        showSaveImageAlert = true
//                    }){
//                        Image(systemName: "arrow.down.circle")
//                            .font(.title)
//                    }
//                    .alert(isPresented: $showSaveImageAlert) {
//                        Alert(
//                            title: Text("画像を保存します"),
//                            message: Text("現在選択中のキャラクターの画像を保存します。"),
//                            primaryButton: .cancel(Text("キャンセル")),
//                            secondaryButton: .default(Text("保存する"), action: {
//                                let impactLight = UIImpactFeedbackGenerator(style: .light)
//                                impactLight.impactOccurred()
//
//                                // 表示中の画像を保存する
//                                if tappedImageIndex == -1 {
//                                    ImageSaver($showSaveImageAlert).writeToPhotoAlbum(image: UIImage(named: self.timeManager.phasesImageList[self.timeManager.phasesCount])!)
//
//                                } else if tappedImageIndex < (self.timeManager.phasesCount + 1) {
//                                    ImageSaver($showSaveImageAlert).writeToPhotoAlbum(image: UIImage(named: self.timeManager.phasesImageList[tappedImageIndex])!)
//
//                                } else {
//                                    ImageSaver($showSaveImageAlert).writeToPhotoAlbum(image: UIImage(named: "Question")!)
//
//                                }
//                                // アラームを閉じる
//                                showSaveImageAlert = false
//                            }))
//                    }
                    
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
                    
                    // 表示中のキャラクターを育成対象に変更する
                    Button(action: {
                        if self.timeManager.selectedCharacter != self.timeManager.selectedDetailCharacterName {
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
                            message: Text("現在育成中のキャラクターの育成を中断し、このキャラクターの育成を開始します。"),
                            primaryButton: .cancel(Text("キャンセル")),
                            secondaryButton: .default(Text("育成する"), action: {
                                let impactLight = UIImpactFeedbackGenerator(style: .light)
                                impactLight.impactOccurred()
                                // 表示中のキャラクターを育成対象に変更する
                                self.timeManager.expTime = 0
                                withAnimation {
                                    self.timeManager.selectedCharacter = self.timeManager.selectedDetailCharacterName
                                    self.timeManager.loadSelectedCharacterData()
                                }
                                // アラームを閉じる
                                showSelectGrowCharacterAlert = false
                            }))
                    }
                    .opacity(self.timeManager.selectedCharacter != self.timeManager.selectedDetailCharacterName ? 1.0 : 0.1)
                    .foregroundColor(self.timeManager.selectedCharacter != self.timeManager.selectedDetailCharacterName ? Color.blue : Color(UIColor.darkGray))
                    
                    Spacer()
                }
                .padding(.top, 80)
                .padding(.trailing, 20)

            }
            
            Spacer()
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView()
            .environmentObject(TimeManager())
    }
}
