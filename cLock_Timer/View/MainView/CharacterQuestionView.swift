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
                
                Group {
                    Text("● Egg(エッグ)いキャラクターとは？")
                        .font(.title2.bold())
                    
                    Text("　Eggいタイマーのキャラクターデザインチームが描き上げた完全オリジナルキャラクターです。絵だけではなく、設定なども結構考えているので、ぜひキャラクターを開放したら読んでみてください！")
                        .font(.title3)
                }
                
                Group {
                    
                    Text("● 育成方法")
                        .font(.title2.bold())
                        .padding(.top)
                    Text("　基本的にタスクを実行した時間によって成長します。その時間はキャラクターによって多少変化しますが、ユーザーが設定したタスク実行時間によって定義されています。")
                        .font(.title3)
                }
                
                Group {
                    Text("● 育成キャラの入れ替えについて")
                        .font(.title2.bold())
                        .padding(.top)
                    Text("○ 未獲得のキャラについて")
                        .font(.title3.bold())
                        .padding(.top, 3)
                    Image("hint_1")
                        .resizable()
                        .scaledToFit()
                        .padding()
                    Text("　キャラクターは同時に一体のみ育成可能です。未所持の卵を育成したい場合は、キャラクター画像の右側の🔄ボタンを押して、タマゴを入れ替えてください。ただし、前回育てていたキャラクターの育成状態は中断されます。つまり、このボタンを押してお目当ての卵が出るまで何度でもこのボタンで入れ替え可能で、一度でも表示された卵は、1段階目を取得したことになり、未所持キャラの一覧から獲得済みのキャラ一覧へ移動します。")
                        .font(.title3)
                    Text("○ 獲得済みのキャラについて")
                        .font(.title3.bold())
                        .padding(.top, 3)
                    Image("hint_3")
                        .resizable()
                        .scaledToFit()
                        .padding()
                    Text("　過去に獲得済みのキャラクターを育成したい場合は、育成したいキャラクターを獲得済みのキャラ一覧から選択し、キャラクター画面の右側のダンベルの形のボタンを押して、育成する対象を入れ替えましょう。ただし、前回育てていたキャラクターの育成状態は中断されます。いろいろなキャラを育ててみましょう！")
                        .font(.title3)
                }
                
                Group {
                    Text("● 取得キャラについて")
                        .font(.title2.bold())
                        .padding(.top)
                    Image("hint_2")
                        .resizable()
                        .scaledToFit()
                        .padding()
                    Text("　タスクを実行したことによって、取得し解放されたキャラクターはホーム画面のウィジェットに表示することができます。ウィジェットに設定するには、キャラクターの画像の右側の＋ボタンを押してください。\n　ウィジェットとは、ホーム画面にアプリのシステムの一部を表示することのできる機能です。")
                        .font(.title3)
                    
                    Text("○ Widget（ウィジェット）について")
                        .font(.title3.bold())
                        .padding(.top, 3)
                    Image("hint_4")
                        .resizable()
                        .scaledToFit()
                        .padding()
                    Text("　ウィジェットとは、ホーム画面にアプリのシステムの一部を表示することのできる機能です。ウィジェットをホーム画面に追加するためには、ホーム画面を長押しし、画面左上に表示された+ボタンを押して、このアプリのウィジェットを選択して追加してください。ぜひ、お気に入りのキャラクターをホーム画面に表示してみましょう！")
                        .font(.title3)
                }
            }
            .padding(.vertical, 50)
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
