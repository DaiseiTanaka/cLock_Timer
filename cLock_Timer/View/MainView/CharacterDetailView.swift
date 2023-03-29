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
    
    @State var tappedImageIndex: Int = -1
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    if tappedImageIndex == -1{
                        VStack {
                            Image(self.timeManager.phasesImageList[self.timeManager.phasesCount])
                                .resizable()
                                .frame(width: imageSize, height: imageSize)
                            
                            Text(self.timeManager.phasesNameList[self.timeManager.phasesCount])
                                .font(.title2.bold())
                        }
                        .padding(.top, 70)
                        .padding(.bottom, 40)
                        
                    } else if tappedImageIndex < (self.timeManager.phasesCount + 1) {
                        VStack {
                            Image(self.timeManager.phasesImageList[tappedImageIndex])
                                .resizable()
                                .frame(width: imageSize, height: imageSize)
                            
                            Text(self.timeManager.phasesNameList[tappedImageIndex])
                                .font(.title2.bold())
                        }
                        .padding(.top, 70)
                        .padding(.bottom, 40)
                        
                    } else {
                        VStack {
                            Image("Question")
                                .resizable()
                                .frame(width: imageSize, height: imageSize)
                                .background(
                                    Color(UIColor.systemGray)
                                        .cornerRadius(imageSize)
                                        .shadow(radius: 3)
                                        .opacity(0.5)
                                )
                            Text("???")
                                .font(.title2.bold())
                        }
                        .padding(.top, 70)
                        .padding(.bottom, 40)
                    }
                }
                
                
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
                                        .shadow(color: num + self.timeManager.phasesCount == tappedImageIndex ? .blue : .black, radius: 3)
                                        .opacity(0.5)
                                )
                                .padding(5)
                                .onTapGesture {
                                    tappedImageIndex = num + self.timeManager.phasesCount + 1
                                }
                        }
                        
                        Spacer()
                    }
                }
                .padding(.top, 10)

                Spacer()
            }
            
            resetCharacterButton
        }
    }
    
    var resetCharacterButton: some View {
        VStack {
            HStack {
                Button {
                    withAnimation {
                        UserDefaults.standard.removeObject(forKey: "possessionList")
                        self.timeManager.possessionList = [:]
                        self.timeManager.selectCharacter()
                        self.timeManager.expTime = 0
                        self.timeManager.loadCharacterImage()
                        //dismiss()
                    }
                } label: {
                    Image(systemName: "trash.circle.fill")
                        .font(.title)
                        .padding(.leading, 30)
                        .padding(.top, 50)
                }
                
                Spacer()
                
                Button {
                    withAnimation {
                        self.timeManager.selectCharacter()
                        self.timeManager.expTime = 0
                        self.timeManager.loadCharacterImage()
                        self.timeManager.saveUserData()
                        dismiss()
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
