//
//  HowToUseView.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/04/19.
//

import SwiftUI

struct HowToUseView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                VStack(spacing: 30) {
                    // MARK: -アプリの機能紹介
                    Text("~ アプリの使い方 ~")
                        .font(.title.bold())
                    Group {
                        Text("● タスクの実施について")
                            .font(.title2.bold())
                        
                        Group {
                            Text("　タスクの実施時間は、タイマー画面を表示している間のみカウントされます。そのためタスク実行中は必ずタイマー画面を表示したままにしてください。")
                                .font(.title3)
                        }
                        
                        Text("● 各画面の機能")
                            .font(.title2.bold())
                        
                        Group {
                            Text("○ データ画面")
                                .font(.title3.bold())
                                .padding(.top, 3)
                            Image("hint-tab-1")
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 300)
                            Text("　画面下の表示されている左から1番目のボタンを押した時に表示される画面です。\n　この画面では、タスクの実行実績を確認することができます。また画面右下に表示されている緑色のボタンを押すと、所持しているポイントを利用することのできる画面が表示されます。")
                                .font(.title3)
                        }
                        
                        Group {
                            Text("○ キャラクター画面")
                                .font(.title3.bold())
                                .padding(.top, 3)
                            Image("hint-tab-2")
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 300)
                            Text("　画面下の表示されている左から2番目のボタンを押した時に表示される画面です。\n　この画面では、キャラクターの情報を確認することができます。獲得済みのキャラ一覧から獲得済みのキャラクターを確認することができ、画面右上のボタンでウィジェットへの表示や育成を開始することができます。")
                                .font(.title3)
                        }
                        
                        Group {
                            Text("○ タイマー画面")
                                .font(.title3.bold())
                                .padding(.top, 3)
                            Image("hint-tab-3")
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 300)
                            Text("　画面下の表示されている左から3番目のボタンを押した時に表示される画面です。\n　タスク実施中は必ずこの画面を表示してください。この画面を表示している間のみタスク実行時間がカウントされます。またこの画面は設定画面で自由に表示内容をカスタムすることができます。")
                                .font(.title3)
                        }
                        
                        Group {
                            Text("○ ポイント画面")
                                .font(.title3.bold())
                                .padding(.top, 3)
                            Image("hint-tab-4")
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 300)
                            Text("　画面下の表示されている左から4番目のボタンを押した時に表示される画面です。\n　この画面では、タスクの実施によって獲得されたEggいポイントを育成、またはガチャに使うことができます。")
                                .font(.title3)
                        }
                        
                        Group {
                            Text("○ 設定画面")
                                .font(.title3.bold())
                                .padding(.top, 3)
                            Image("hint-tab-5")
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 300)
                            Text("　画面下の表示されている左から5番目のボタンを押した時に表示される画面です。\n　この画面では、アプリ全体の各種設定を行うことができます。またタスク内容を更新したり、アプリの使い方を確認したりすることができます。")
                                .font(.title3)
                        }
                    }
                    
                    // MARK: -キャラクターについての説明
                    Text("~ キャラについて ~")
                        .font(.title.bold())
                        .padding(.top)
                    
                    Group {
                        Group {
                            Text("● Egg(エッグ)いキャラクターとは？")
                                .font(.title2.bold())
                            Image("Frog-3")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .padding()
                            Text("　Eggいタイマーのキャラクターデザインチームが描き上げた完全オリジナルキャラクターです。絵だけではなく、設定なども結構考えているので、ぜひキャラクターを開放したら読んでみてください！")
                                .font(.title3)
                        }
                        
                        Group {
                            Text("● 育成方法")
                                .font(.title2.bold())
                                .padding(.top)
                            Image("hint-grow-character")
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 300, height: 300)
                            Text("　基本的にタスクを実行した時間によって手に入る「Eggいポイント」によって成長させることができます。ポイントはポイント画面を開いて育成、またはガチャに使うことができます。また設定でポイントを自動的に育成に充てる機能もあります。")
                                .font(.title3)
                        }
                        
                        Group {
                            Text("● 育成キャラの入れ替えについて")
                                .font(.title2.bold())
                                .padding(.top)
                            Text("○ 未獲得のキャラについて")
                                .font(.title3.bold())
                                .padding(.top, 3)
                            Image("hint-get-character")
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 300, height: 300)
                            Text("　キャラクターは同時に一体のみ育成可能です。未所持のタマゴを育成したい場合は、ポイントを貯めてガチャを引くことで獲得することができます。このガチャでは未所持のタマゴのみ獲得可能であり、獲得したタマゴをすぐに育成するか、あとで育成するか選ぶことができます。")
                                .font(.title3)
                            Text("○ 獲得済みのキャラについて")
                                .font(.title3.bold())
                                .padding(.top, 3)
                            Image("hint_3")
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 300, height: 300)
                            Text("　過去に獲得済みのキャラクターを育成したい場合は、育成したいキャラクターを「キャラクター画面」の「獲得済みのキャラ一覧」から選択し、右側の「ダンベルの形のボタン」を押して、育成する対象を入れ替えましょう。ただし、前回育てていたキャラクターの育成状態は中断されます。いろいろなキャラを育ててみましょう！")
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
                                .frame(width: 300, height: 300)
                            Text("　タスクを実行したことによって、取得し解放されたキャラクターはホーム画面のウィジェットに表示することができます。ウィジェットに設定するには、キャラクターの画像の右側の「＋ボタン」を押してください。\n　ウィジェットとは、ホーム画面にアプリのシステムの一部を表示することのできる機能です。")
                                .font(.title3)
                            
                            Text("○ Widget（ウィジェット）について")
                                .font(.title3.bold())
                                .padding(.top, 3)
                            Image("hint_4")
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 300, height: 300)
                            Text("　ウィジェットとは、ホーム画面にアプリのシステムの一部を表示することのできる機能です。ウィジェットをホーム画面に追加するためには、ホーム画面を長押しし、画面左上に表示された+ボタンを押して、このアプリのウィジェットを選択して追加してください。ぜひ、お気に入りのキャラクターをホーム画面に表示してみましょう！")
                                .font(.title3)
                        }
                    }
                }
                .padding(.vertical, 50)
                .padding(.horizontal)
            }
            .scrollIndicators(.hidden)
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }){
                        HStack {
                            Spacer()
                            
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .foregroundColor(Color.gray)
                                .frame(width: 30, height: 30)
                                .padding(.top, 50)
                                .padding(.trailing, 20)
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

struct HowToUseView_Previews: PreviewProvider {
    static var previews: some View {
        HowToUseView()
    }
}
