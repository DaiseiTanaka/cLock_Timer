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
    
    var body: some View {
        ZStack {

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    // 選択中のキャラクターの画像
                    selectedCharacterView
                    
                    // 選択中のキャラクターの解放済み進化形態の一覧
                    selectedCharacterArray
                        .padding(.top, 10)
                    
                    // 選択中のキャラクターの解放状態がMAXの時にキャラクターの詳細を表示
                    if self.timeManager.phasesCount == 8 {
                        Text(self.timeManager.selectedCharacterDetail)
                            .font(.body.bold())
                            .padding(.top, 30)
                            .padding(.horizontal, 20)
                    }
                    
                    // 取得済みのキャラクターの一覧を表示
                    possessionCharacterList
                    
                    Spacer()
                }
                

            }
            
            // ボタン
            resetCharacterButton
        }
    }
    
    var selectedCharacterView: some View {
        ZStack {
            if tappedImageIndex == -1 {
                VStack(spacing: 40) {
                    Image(self.timeManager.phasesImageList[self.timeManager.phasesCount])
                        .resizable()
                        .frame(width: imageSize, height: imageSize)
                        .shadow(color: .black.opacity(0.3), radius: 5)

                    
                    Text(self.timeManager.phasesNameList[self.timeManager.phasesCount])
                        .font(.title2.bold())
                }
                .padding(.top, 70)
                
            } else if tappedImageIndex < (self.timeManager.phasesCount + 1) {
                VStack(spacing: 40) {
                    Image(self.timeManager.phasesImageList[tappedImageIndex])
                        .resizable()
                        .frame(width: imageSize, height: imageSize)
                        .shadow(color: .black.opacity(0.3), radius: 5)

                    
                    Text(self.timeManager.phasesNameList[tappedImageIndex])
                        .font(.title2.bold())
                }
                .padding(.top, 70)
                
            } else {
                VStack(spacing: 40) {
                    Image("Question")
                        .resizable()
                        .frame(width: imageSize, height: imageSize)
                        .background(
                            Color(UIColor.systemGray)
                                .cornerRadius(imageSize)
                                .shadow(radius: 3)
                                .opacity(0.5)
                        )
                        .shadow(color: .black.opacity(0.3), radius: 5)

                    Text("???")
                        .font(.title2.bold())
                }
                .padding(.top, 70)
            }
            
//            VStack {
//                Spacer()
//                HStack {
//                    Image(systemName: "chevron.left")
//                        .padding(.leading, 30)
//                        .onTapGesture {
//                            if tappedImageIndex > 0 {
//                                let impactLight = UIImpactFeedbackGenerator(style: .light)
//                                impactLight.impactOccurred()
//                                withAnimation {
//                                    tappedImageIndex -= 1
//                                }
//                            } else if tappedImageIndex == -1 {
//                                let impactLight = UIImpactFeedbackGenerator(style: .light)
//                                impactLight.impactOccurred()
//                                withAnimation {
//                                    tappedImageIndex = self.timeManager.phasesCount - 1
//                                }
//                            }
//                        }
//                        .opacity(tappedImageIndex != 0  || !(tappedImageIndex == -1 && self.timeManager.phasesCount == 0) ? 1.0 : 0.2)
//
//                    Spacer()
//
//                    Image(systemName: "chevron.right")
//                        .padding(.trailing, 30)
//                        .onTapGesture {
//                            if tappedImageIndex < self.timeManager.phasesImageList.count - 1 {
//                                let impactLight = UIImpactFeedbackGenerator(style: .light)
//                                impactLight.impactOccurred()
//                                withAnimation {
//                                    tappedImageIndex += 1
//                                }
//                            } else if tappedImageIndex == -1 {
//                                let impactLight = UIImpactFeedbackGenerator(style: .light)
//                                impactLight.impactOccurred()
//                                withAnimation {
//                                    tappedImageIndex = self.timeManager.phasesCount + 1
//                                }
//                            }
//                        }
//                        .opacity(tappedImageIndex != self.timeManager.phasesImageList.count - 1 || !(tappedImageIndex == -1 && self.timeManager.phasesCount == self.timeManager.phasesImageList.count - 1) ? 1.0 : 0.2)
//                }
//                Spacer()
//            }
        }
        .padding(.horizontal, 20)

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
                            
                            tappedImageIndex = num
                        }

                }
                ForEach(0 ..< (self.timeManager.phasesImageList.count - self.timeManager.phasesCount - 1), id: \.self) { num in
                    Image("Question")
                        .resizable()
                        .frame(width: circleDiameter, height: circleDiameter)
                        .cornerRadius(circleDiameter)
                        .background(
                            Color(UIColor.systemGray)
                                .cornerRadius(circleDiameter)
                                .shadow(color: num + self.timeManager.phasesCount + 1 == tappedImageIndex ? .blue : .black, radius: 3)
                                .opacity(0.5)
                        )
                        .padding(5)
                        .onTapGesture {
                            let impactLight = UIImpactFeedbackGenerator(style: .light)
                            impactLight.impactOccurred()
                            
                            tappedImageIndex = num + self.timeManager.phasesCount + 1
                        }
                }
                
                Spacer()
            }
        }
    }
    
    var possessionCharacterList: some View {
        VStack(spacing: 0) {
            if self.timeManager.firstEggImageList.count != 0 {
                Text("獲得済みのキャラ \(self.timeManager.firstEggImageList.count)種")
                    .font(.title3.bold())
                    .padding(.top, 50)
                
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
                                    
                                    tappedPossessionIndex = num
                                    self.timeManager.loadCharacterDetailData(selectedDetailCharacter: self.timeManager.firstEggImageList[num][0])
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
                                    
                                    tappedNotPossessionIndex = num
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
                Spacer()
                
                Button {
                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                    impactLight.impactOccurred()
                    
                    withAnimation {
                        self.timeManager.expTime = 0
                        self.timeManager.selectedCharacter = self.timeManager.selectCharacter()
                        self.timeManager.loadSelectedCharacterData()
                        self.timeManager.loadCharacterDetailData(selectedDetailCharacter: self.timeManager.selectedCharacter)
//                        self.timeManager.saveUserData()
                        //dismiss()
                    }
                } label: {
                    Image(systemName: "arrow.counterclockwise.circle.fill")
                        .font(.title)
                        .padding(.trailing, 30)
                        .padding(.top, 50)
                }
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
