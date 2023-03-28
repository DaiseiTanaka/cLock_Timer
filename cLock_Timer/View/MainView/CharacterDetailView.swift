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

    
    var body: some View {
        VStack {
            Image(self.timeManager.selectedCharacterImageName)
                .resizable()
                .frame(width: 200, height: 200)
                .padding()
            
            Button {
                withAnimation {
                    self.timeManager.selectCharacter()
                    self.timeManager.loadCharacterImage()
                    self.timeManager.expTime = 0
                    self.timeManager.saveUserData()
                    dismiss()
                }
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .font(.title2)
            }
            
            Spacer()
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView()
    }
}
