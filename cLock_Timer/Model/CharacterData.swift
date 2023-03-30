//
//  CharacterData.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/03/28.
//

import SwiftUI

let CharacterData: [String : Any] = [
    "rabit": [
        "Name": "rabit",
        "HP": UserDefaults.standard.double(forKey: "taskTime") > 60 ? UserDefaults.standard.double(forKey: "taskTime") * 7 * 0.5 : 420,
        "ExpRatio": [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8],
        "Images": [
            "egg-white-1",
            "egg-white-2",
            "egg-white-3",
            "s-white-1",
            "s-white-2",
            "s-white-3",
            "Rabit-1",
            "Rabit-2",
            "Rabit-3"
        ],
        "PhaseName": [
            "白い卵",
            "少し割れた白い卵",
            "かなり割れた白い卵",
            "白い子スライム",
            "白い青年スライム",
            "白い成人スライム",
            "頭の割れ始めたスライム",
            "うさぎスライム",
            "仁王立ちするうさぎ"
        ],
        "Detail": "　卵からウサギが生まれました。珍しいこともあるものですね。"
    ],
    "frog": [
        "Name": "frog",
        "HP": UserDefaults.standard.double(forKey: "taskTime") > 60 ? UserDefaults.standard.double(forKey: "taskTime") * 7 * 0.75 : 420,
        "ExpRatio": [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8],
        "Images": [
            "egg-green-1",
            "egg-green-2",
            "egg-green-3",
            "s-green-1",
            "s-green-2",
            "s-green-3",
            "Frog-1",
            "Frog-2",
            "Frog-3"
        ],
        "PhaseName": [
            "緑の卵",
            "少し割れた緑の卵",
            "かなり割れた緑の卵",
            "緑の子スライム",
            "緑の青年スライム",
            "緑の成人スライム",
            "手足の生えた緑のスライム",
            "太い足の生えたスライム",
            "雄叫びを上げるカエル"
        ],
        "Detail": "　どこかで見たことのあるカエルですね。まるで相撲でウサギを投げ飛ばしたかのようなポーズです。 口から高温の炎を出しながら、雄叫びを上げています。"
    ],
    "chicken": [
        "Name": "chicken",
        "HP": UserDefaults.standard.double(forKey: "taskTime") > 60 ? UserDefaults.standard.double(forKey: "taskTime") * 7 * 1.25 : 420,
        "ExpRatio": [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8],
        "Images": [
            "egg-brown-1",
            "egg-brown-2",
            "egg-brown-3",
            "s-brown-1",
            "s-brown-2",
            "s-brown-3",
            "Chicken-1",
            "Chicken-2",
            "Chicken-3"
        ],
        "PhaseName": [
            "茶色の卵",
            "少し割れた茶色の卵",
            "かなり割れた茶色の卵",
            "茶色の子スライム",
            "茶色の青年スライム",
            "茶色の成人スライム",
            "頭の先端が赤くなったスライム",
            "太い足の生えた頭の赤いスライム",
            "鳳凰"
        ],
        "Detail": "　鶏を育てていたら鳳凰（ほうおう）になりました。鳳凰は、中国神話の伝説の鳥、霊鳥です。鳳皇とも言います。日本を含む東アジア広域にわたって、装飾やシンボル、物語・説話・説教などで登場します。"
    ],
    "unicorn": [
        "Name": "unicorn",
        "HP": UserDefaults.standard.double(forKey: "taskTime") > 60 ? UserDefaults.standard.double(forKey: "taskTime") * 7 * 1.5 : 420,
        "ExpRatio": [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.9],
        "Images": [
            "egg-rainbow-1",
            "egg-rainbow-2",
            "egg-rainbow-3",
            "s-rainbow-1",
            "s-rainbow-2",
            "s-rainbow-3",
            "Unicorn-1",
            "Unicorn-2",
            "Unicorn-3"
        ],
        "PhaseName": [
            "虹色の卵",
            "少し割れた虹色の卵",
            "かなり割れた虹色の卵",
            "虹色の子スライム",
            "虹色の青年スライム",
            "虹色の成人スライム",
            "頭の先端が黄色くなったスライム",
            "黄色い角の生えた四足歩行生物",
            "ユニコーン"
        ],
        "Detail": "　ユニコーンは、一角獣とも呼ばれ、額の中央に一本の角が生えた馬に似た伝説の生き物です。角には蛇などの毒で汚された水を清める力があるという。海の生物であるイッカクの角はユニコーンの角として乱獲されたとも言われる。"
    ],
    "genger": [
        "Name": "genger",
        "HP": UserDefaults.standard.double(forKey: "taskTime") > 60 ? UserDefaults.standard.double(forKey: "taskTime") * 7 * 1.5 : 420,
        "ExpRatio": [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.8, 1.0],
        "Images": [
            "egg-black-1",
            "egg-black-2",
            "egg-black-3",
            "s-black-1",
            "s-black-2",
            "s-black-3",
            "Genger-1",
            "Genger-2",
            "Genger-3"
        ],
        "PhaseName": [
            "黒色の卵",
            "少し割れた黒色の卵",
            "かなり割れた黒色の卵",
            "黒色の子スライム",
            "黒色の青年スライム",
            "黒色の成人スライム",
            "ダークゴースト",
            "ダークゴースト（戦闘体制）",
            "米粒"
        ],
        "Detail": "「おい、嘘だろ、、、」\n彼の姿を見た者は皆そう言います。バケモノの言うことなんか信じられないと言ってくる人間たちに対して彼は言います。「人間の言うことなら信じられるのか」"
    ],
    "deer-normal": [
        "Name": "deer-normal",
        "HP": UserDefaults.standard.double(forKey: "taskTime") > 60 ? UserDefaults.standard.double(forKey: "taskTime") * 7 * 1.0 : 420,
        "ExpRatio": [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 1.0],
        "Images": [
            "egg-brown-circle-1",
            "egg-brown-circle-2",
            "egg-brown-circle-3",
            "s-bambi-1",
            "s-bambi-2",
            "s-bambi-3",
            "deer-1",
            "deer-2",
            "deer-normal-3"
        ],
        "PhaseName": [
            "茶色い斑点のある卵",
            "少し割れた茶色い斑点のある卵",
            "かなり割れた茶色い斑点のある卵",
            "潰れた茶色い斑点のある卵",
            "潰れたとこからツノが出てきたスライム",
            "ツノを手に入れたことによって自信を取り戻したスライム",
            "ツノが板についてきたスライム",
            "鹿としての意識が芽生えたスライム",
            "鹿（ノーマルver）"
        ],
        "Detail": "ノーマル、、なのか、、、？\nいったい何を両手に掲げているのでしょうか。"
    ],
    "deer-special": [
        "Name": "deer-special",
        "HP": UserDefaults.standard.double(forKey: "taskTime") > 60 ? UserDefaults.standard.double(forKey: "taskTime") * 7 * 1.5 : 420,
        "ExpRatio": [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 1.0],
        "Images": [
            "egg-brown-circle-1",
            "egg-brown-circle-2",
            "egg-brown-circle-3",
            "s-bambi-1",
            "s-bambi-2",
            "s-bambi-3",
            "deer-1",
            "deer-2",
            "deer-special-3"
        ],
        "PhaseName": [
            "茶色い斑点のある卵",
            "少し割れた茶色い斑点のある卵",
            "かなり割れた茶色い斑点のある卵",
            "潰れた茶色い斑点のある卵",
            "潰れたとこからツノが出てきたスライム",
            "ツノを手に入れたことによって自信を取り戻したスライム",
            "ツノが板についてきたスライム",
            "鹿としての意識が芽生えたスライム",
            "鹿（スペシャルver）"
        ],
        "Detail": "彼は何を見て、何を感じているのか。全てを見て、全てを感じているのでしょう。歴史を回想し、未来を想像しながら森を守る、まごうことなき森の王です。"
    ],
    // MARK: - 都道府県
    "saitama": [
        "Name": "saitama",
        "HP": UserDefaults.standard.double(forKey: "taskTime") > 60 ? UserDefaults.standard.double(forKey: "taskTime") * 7 * 1.0 : 420,
        "ExpRatio": [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.8, 1.0],
        "Images": [
            "egg-red-circle-1",
            "egg-red-circle-3",
            "egg-red-circle-4",
            "egg-red-circle-5",
            "egg-red-circle-6",
            "egg-red-circle-7",
            "egg-red-circle-8",
            "p-saitama-normal",
            "p-saitama-eye"
        ],
        "PhaseName": [
            "赤い斑点のある卵",
            "少し割れた赤い斑点のある卵",
            "かなり割れた赤い斑点のある卵",
            "潰れた赤い斑点のある卵",
            "潰れたとこから出てきたスライム",
            "日本国民としての意識が芽生えたスライム",
            "変形中のスライム",
            "サイタマノーマル",
            "サイタマ"
        ],
        "Detail": "埼玉県（さいたまけん）は、日本の関東地方に位置する県。県庁所在地はさいたま市。"
    ],
    "tokyo": [
        "Name": "tokyo",
        "HP": UserDefaults.standard.double(forKey: "taskTime") > 60 ? UserDefaults.standard.double(forKey: "taskTime") * 7 * 1.0 : 420,
        "ExpRatio": [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.8, 1.0],
        "Images": [
            "egg-red-circle-1",
            "egg-red-circle-3",
            "egg-red-circle-4",
            "egg-red-circle-5",
            "egg-red-circle-6",
            "egg-red-circle-7",
            "egg-red-circle-8",
            "p-tokyo-normal",
            "p-tokyo-eye"
        ],
        "PhaseName": [
            "赤い斑点のある卵",
            "少し割れた赤い斑点のある卵",
            "かなり割れた赤い斑点のある卵",
            "潰れた赤い斑点のある卵",
            "潰れたとこから出てきたスライム",
            "日本国民としての意識が芽生えたスライム",
            "変形中のスライム",
            "トーキョーノーマル",
            "トーキョー"
        ],
        "Detail": "東京都（とうきょうと、英語: Tokyo Metropolis）は、日本の首都。関東地方に位置する都。都庁所在地は新宿区。"
    ],
    "kanagawa": [
        "Name": "kanagawa",
        "HP": UserDefaults.standard.double(forKey: "taskTime") > 60 ? UserDefaults.standard.double(forKey: "taskTime") * 7 * 1.0 : 420,
        "ExpRatio": [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.8, 1.0],
        "Images": [
            "egg-red-circle-1",
            "egg-red-circle-3",
            "egg-red-circle-4",
            "egg-red-circle-5",
            "egg-red-circle-6",
            "egg-red-circle-7",
            "egg-red-circle-8",
            "p-kanagawa-normal",
            "p-kanagawa-eye"
        ],
        "PhaseName": [
            "赤い斑点のある卵",
            "少し割れた赤い斑点のある卵",
            "かなり割れた赤い斑点のある卵",
            "潰れた赤い斑点のある卵",
            "潰れたとこから出てきたスライム",
            "日本国民としての意識が芽生えたスライム",
            "変形中のスライム",
            "カナガワノーマル",
            "カナガワ"
        ],
        "Detail": "神奈川県（かながわけん）は、日本の関東地方に位置する県。県庁所在地は横浜市。"
    ],
    "yamanashi": [
        "Name": "yamanashi",
        "HP": UserDefaults.standard.double(forKey: "taskTime") > 60 ? UserDefaults.standard.double(forKey: "taskTime") * 7 * 1.0 : 420,
        "ExpRatio": [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.8, 1.0],
        "Images": [
            "egg-red-circle-1",
            "egg-red-circle-3",
            "egg-red-circle-4",
            "egg-red-circle-5",
            "egg-red-circle-6",
            "egg-red-circle-7",
            "egg-red-circle-8",
            "p-yamanashi-normal",
            "p-yamanashi-eye"
        ],
        "PhaseName": [
            "赤い斑点のある卵",
            "少し割れた赤い斑点のある卵",
            "かなり割れた赤い斑点のある卵",
            "潰れた赤い斑点のある卵",
            "潰れたとこから出てきたスライム",
            "日本国民としての意識が芽生えたスライム",
            "変形中のスライム",
            "ヤマナシノーマル",
            "ヤマナシ"
        ],
        "Detail": "山梨県（やまなしけん）は、日本の中部地方に位置する県。県庁所在地は甲府市。首都圏整備法における首都圏の一角を成す。令制国の甲斐国に相当する。"
    ],
    "shizuoka": [
        "Name": "shizuoka",
        "HP": UserDefaults.standard.double(forKey: "taskTime") > 60 ? UserDefaults.standard.double(forKey: "taskTime") * 7 * 1.0 : 420,
        "ExpRatio": [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.8, 1.0],
        "Images": [
            "egg-red-circle-1",
            "egg-red-circle-3",
            "egg-red-circle-4",
            "egg-red-circle-5",
            "egg-red-circle-6",
            "egg-red-circle-7",
            "egg-red-circle-8",
            "p-shizuoka-normal",
            "p-shizuoka-eye"
        ],
        "PhaseName": [
            "赤い斑点のある卵",
            "少し割れた赤い斑点のある卵",
            "かなり割れた赤い斑点のある卵",
            "潰れた赤い斑点のある卵",
            "潰れたとこから出てきたスライム",
            "日本国民としての意識が芽生えたスライム",
            "変形中のスライム",
            "シズオカノーマル",
            "シズオカ"
        ],
        "Detail": "静岡県（しずおかけん）は、日本の中部地方に位置する県。県庁所在地は静岡市。"
    ]
]
