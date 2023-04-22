//
//  GachaView.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/04/18.
//

import SwiftUI


struct GachaView: View {
    @EnvironmentObject var timeManager: TimeManager
    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    let backGroundColor = LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.7), Color.black.opacity(0.9)]), startPoint: .top, endPoint: .bottom)
    
    let titleSize: CGFloat = 50
    let imageSize: CGFloat = 180
    let eggNameSize: CGFloat = 30
    let buttonTextSize: CGFloat = 18
    
    @State private var tappedFlag: Bool = true
    @State private var displayEggDetailFlag: Bool = false
    @State private var eggAppearFlag: Bool = false
    
    @State private var newCharacterName: String = ""
    @State private var eggImageName: String = ""
    @State private var eggNameString: String = ""
    
    @State private var isTapAnimation: Bool = false
    @State private var isEggAnimation: Bool = false
    
    @State private var backgoundImageName: String = ""
    
    // 画面の向きを制御
    @State private var orientation: UIDeviceOrientation
    @State private var portraitOrNotFlag: Bool = true
    init() {
        self._orientation = State(wrappedValue: UIDevice.current.orientation)
    }
    
    
    var body: some View {
        ZStack {
            Image("\(backgoundImageName)")
                .resizable()
                //.scaledToFit()
                .ignoresSafeArea()
                //.frame(maxWidth: .infinity, maxHeight: .infinity)
            
            backGroundColor.edgesIgnoringSafeArea(.all)
            
            if tappedFlag {
                VStack {
                    Spacer()
                    Text("タップ!")
                        .font(.system(size: titleSize, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .onAppear {
                            isTapAnimation = true
                        }
                        .scaleEffect(isTapAnimation ? 1.3 : 1.0)
                        .animation(.default.repeatForever(autoreverses: true), value: isTapAnimation)
                    Spacer()
                }
            }
            
            // 縦画面の時
            if portraitOrNotFlag {
                VStack(spacing: 10) {
                    if displayEggDetailFlag {
                        Text("獲得！")
                            .font(.system(size: titleSize, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    }
                    
                    newEggImageView
                    
                    if displayEggDetailFlag {
                        newEggDetailView
                        
                        Text("「あとで育成する」を選択すると、今回獲得したタマゴは獲得済みリストに保存され、いつからでも育成が可能です。")
                            .foregroundColor(Color.white)
                            .padding(.top, 30)
                    }
                }
                .frame(width: min(screenWidth, screenHeight) - 40)
                
                // 横画面の時
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        Spacer(minLength: 0)
                        
                        HStack(spacing: 20) {
                            Spacer(minLength: 0)
                            
                            newEggImageView
                            
                            if displayEggDetailFlag {
                                newEggDetailView
                                    .frame(maxWidth: max(screenWidth, screenHeight) / 3)
                                
                            }
                            Spacer(minLength: 0)
                        }
                        //.frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        if displayEggDetailFlag {
                            Text("「あとで育成する」を選択すると、今回獲得したタマゴは獲得済みリストに保存され、いつからでも育成が可能です。")
                                .foregroundColor(Color.white)
                                .padding(.top, 30)
                        }
                        
                        Spacer(minLength: 0)
                    }
                    .frame(width: max(screenWidth, screenHeight), height: min(screenWidth, screenHeight))
                    //.frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            backgoundImageName = returnRandomBackgroundImage()
            portraitOrNotFlag = self.timeManager.returnOrientation()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // 画面の向きが変わったことを検知
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            orientation = UIDevice.current.orientation
        }
        // 画面の向きが変わった時の処理　.onReceive内で実行したら不具合があったため切り離した
        .onChange(of: orientation) { _ in
            portraitOrNotFlag = self.timeManager.returnOrientation()
        }
        .onTapGesture {
            if newCharacterName == "" {
//                let impactLight = UIImpactFeedbackGenerator(style: .light)
//                impactLight.impactOccurred()
                // 未所持のキャラクターを選択する
                newCharacterName = self.timeManager.selectNewCharacter()
                // 画面に表示するためのデータを更新する
                getEggName()
                // 今回獲得したキャラクターを獲得済みリストに追加する
                self.timeManager.updatePossessionList(name: newCharacterName, index: 0)
                
                self.tappedFlag = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    let impactLight = UIImpactFeedbackGenerator(style: .heavy)
                    impactLight.impactOccurred()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    let impactLight = UIImpactFeedbackGenerator(style: .medium)
                    impactLight.impactOccurred()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                    impactLight.impactOccurred()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        displayEggDetailFlag = true
                        let impactLight = UIImpactFeedbackGenerator(style: .heavy)
                        impactLight.impactOccurred()
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    isEggAnimation = true
                }
            }
        }
    }
    
    var newEggImageView: some View {
        ZStack {
            if eggImageName != "" {
                Image(eggImageName)
                    .resizable()
                    .frame(width: !eggAppearFlag ? imageSize : imageSize * 1.3, height: !eggAppearFlag ? imageSize : imageSize * 1.3)
                    .offset(y: !eggAppearFlag ? -screenHeight/2 : 0)
                    .opacity(!eggAppearFlag ? 0.1 : 1.0)
                    .onAppear {
                        self.eggAppearFlag = true
                    }
                    .animation(Animation.interpolatingSpring(stiffness: 70, damping: 5), value: eggAppearFlag)
                    .animation(Animation.interpolatingSpring(stiffness: 70, damping: 5), value: displayEggDetailFlag)
                // タマゴが揺れるアニメーション
                    .rotationEffect(isEggAnimation ? .degrees(-5) : .degrees(5), anchor: UnitPoint(x: 0.5, y: 1.0))
                    .animation(.default.repeatForever(autoreverses: true).speed(0.3), value: isEggAnimation)
            }
        }
    }
    
    var newEggDetailView: some View {
        VStack(spacing: 40) {
            Text("\(eggNameString)")
                .font(.system(size: eggNameSize, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            VStack(spacing: 20) {
                Button(action: {
                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                    impactLight.impactOccurred()
                    //現在育成中のキャラクターと入れ替える
                    self.timeManager.expTime = 0
                    self.timeManager.selectedCharacter = newCharacterName
                    self.timeManager.loadSelectedCharacterData()
                    withAnimation {
                        self.timeManager.showGachaView = false
                    }
                }){
                    HStack(spacing: 5) {
                        Text("このタマゴを育てる")
                            .font(.system(size: buttonTextSize, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding(3)
                    }
                }
                .padding(.horizontal, 7)
                .padding(.vertical, 6)
                .background(Color.green)
                .cornerRadius(20)
                .shadow(color: .black, radius: 5)
                
                Button(action: {
                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                    impactLight.impactOccurred()
                    withAnimation {
                        self.timeManager.showGachaView = false
                    }
                }){
                    HStack(spacing: 5) {
                        Text("あとで育成する")
                            .font(.system(size: buttonTextSize, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding(3)
                    }
                }
                .padding(.horizontal, 7)
                .padding(.vertical, 6)
                .background(Color.green)
                .cornerRadius(20)
                .shadow(color: .black, radius: 5)
            }
        }
        .opacity(displayEggDetailFlag ? 1.0 : 0)
        .animation(Animation.interpolatingSpring(stiffness: 70, damping: 5), value: tappedFlag)
    }
    
    private func getEggName() {
        guard let character = CharacterData[newCharacterName] as? [String : Any] else {
            return
        }
        let images = character["Images"] as! [String]
        let phases = character["PhaseName"] as! [String]
        eggImageName = images[0]
        eggNameString = phases[0]
        print("newEggName: \(eggImageName), eggNameString: \(eggNameString)")
    }
    
    private func returnRandomBackgroundImage() -> String {
        let imageNameList = ["gacha-background-1", "gacha-background-2", "gacha-background-3", "gacha-background-4", "gacha-background-5", "gacha-background-6", "gacha-background-7", "gacha-background-8", "gacha-background-9", "gacha-background-10", "gacha-background-11", "gacha-background-12", "gacha-background-13", "gacha-background-14", "gacha-background-15", "gacha-background-16", "gacha-background-17", "gacha-background-18", "gacha-background-19", "gacha-background-20"]
        let randomInt = Int.random(in: 0...imageNameList.count-1)
        //let randomInt = 2
        let image: String = imageNameList[randomInt]
        print("randomInt: \(randomInt), image: \(image)")

        return image
    }
    
}


struct GachaView_Previews: PreviewProvider {
    static var previews: some View {
        GachaView()
            .environmentObject(TimeManager())
    }
}

