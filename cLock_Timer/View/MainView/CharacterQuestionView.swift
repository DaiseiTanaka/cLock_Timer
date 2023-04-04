//
//  CharacterQuestionView.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/04/02.
//

import SwiftUI

struct CharacterQuestionView: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 30) {
                Text("● Egg(エッグ)いキャラクターとは？")
                    .font(.title2.bold())
                
                Text("　Eggいタイマーのキャラクターデザインチームが描き上げた完全オリジナルキャラクターです。絵だけではなく、設定なども結構考えているので、ぜひキャラクターを開放したら読んでみてください！")
                    .font(.title3)
                
                Text("● 育成方法")
                    .font(.title2.bold())
                    .padding(.top)
                
                Text("　基本的にタスクを実行した時間によって成長します。その時間はキャラクターによって多少変化しますが、ユーザーが設定したタスク実行時間によって定義されています。")
                    .font(.title3)
                
                Text("● キャラの入れ替えについて")
                    .font(.title2.bold())
                    .padding(.top)
                
                Text("　キャラクターは同時に一体のみ育成可能です。そのため、現在育成中のタマゴとは違うタマゴを育成したい場合は、キャラクター画像の右側のボタンを押して、タマゴを入れ替えてください。新しいタマゴはランダムで設定され、前回育てていたキャラクターの育成状態は中断されます。この作業は何度でも繰り返すことができるので、いろいろなキャラを育ててみましょう！")
                    .font(.title3)
                
                Text("● 取得キャラについて")
                    .font(.title2.bold())
                    .padding(.top)
                
                Text("　タスクを実行したことによって、取得し解放されたキャラクターは画像としてスマホに保存したり、ホーム画面のウィジェットに表示することができます。保存やウィジェットに設定するには、キャラクターの画像の右側のボタンを押してください。")
                    .font(.title3)
            }
            .padding(.top, 50)
            .padding(.horizontal)
        }
        .scrollIndicators(.hidden)
    }
}

struct CharacterQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterQuestionView()
    }
}
