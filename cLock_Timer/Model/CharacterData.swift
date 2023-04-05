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
        "No": 1,
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
    "rabit-special": [
        "Name": "rabit-special",
        "No": 2,
        "HP": UserDefaults.standard.double(forKey: "taskTime") > 60 ? UserDefaults.standard.double(forKey: "taskTime") * 7 * 0.5 : 420,
        "ExpRatio": [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.8, 1.0],
        "Images": [
            "egg-white-1",
            "egg-white-2",
            "egg-white-3",
            "s-white-1",
            "s-white-2",
            "s-white-3",
            "Rabit-1",
            "Rabit-2",
            "Rabit-special-3"
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
            "投げ飛ばされたウサギ"
        ],
        "Detail": "　どこかでみたことのあるウサギですね。まるで相撲でカエルに投げ飛ばされたかのようなポーズです。投げ飛ばされながらも本当に楽しそう。"
    ],
    "frog": [
        "Name": "frog",
        "No": 3,
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
        "No": 4,
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
    "chicken-special": [
        "Name": "chicken-special",
        "No": 5,
        "HP": UserDefaults.standard.double(forKey: "taskTime") > 3600 ? UserDefaults.standard.double(forKey: "taskTime") * 7 * 1.0 : 3600,
        "ExpRatio": [0.01, 0.02, 0.03, 0.04, 0.07, 0.1, 0.7, 1.0],
        "Images": [
            "egg-brown-1",
            "egg-brown-2",
            "egg-brown-3",
            "s-brown-1",
            "s-brown-2",
            "s-brown-3",
            "Chicken-special-3",
            "Chicken-special-4",
            "Chicken-special-5"
        ],
        "PhaseName": [
            "茶色の卵",
            "少し割れた茶色の卵",
            "かなり割れた茶色の卵",
            "茶色の子スライム",
            "茶色の青年スライム",
            "茶色の成人スライム",
            "炎の鳥",
            "火の鳥",
            "氷の鳥"
        ],
        "Detail": "　炎の化身たる存在。熱く燃える翼で羽ばたき、冷たく冷え切った人々の心を温め、癒してきた。\n その一方、限りある炎を消費し、人々の冷たい心を吸収していった結果、自身の「心」と「行動」に異常なまでのギャップが生まれてしまい、冷め切った心が暴走してしまう。その結果、自我が崩壊し、氷の化身へと姿を変え、その視界に映るもの全てを凍らせながら飛び去るのだった。"
    ],
    "unicorn": [
        "Name": "unicorn",
        "No": 6,
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
        "No": 7,
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
        "No": 8,
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
        "No": 9,
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
    "fox": [
        "Name": "fox",
        "No": 15,
        "HP": UserDefaults.standard.double(forKey: "taskTime") > 60 ? UserDefaults.standard.double(forKey: "taskTime") * 7 * 1.0 : 420,
        "ExpRatio": [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 1.0],
        "Images": [
            "egg-brown-circle-1",
            "egg-brown-circle-2",
            "egg-brown-circle-3",
            "s-yellow-1",
            "s-yellow-2",
            "s-yellow-3",
            "Fox-1",
            "Fox-2",
            "Fox-3"
        ],
        "PhaseName": [
            "茶色い斑点のある卵",
            "少し割れた茶色い斑点のある卵",
            "かなり割れた茶色い斑点のある卵",
            "黄色い子スライム",
            "黄色い青年スライム",
            "黄色い成人スライム",
            "キツネ（ゆるキャラver）",
            "キツネ",
            "キュウビ"
        ],
        "Detail": "「キュウビ」は、日本の古代神話に登場する九尾の狐（きゅうびのこ）のことを指します。九尾の狐は、9本の尾を持ち、非常に妖艶で知恵があり、人々を惑わし、時には害をもたらす存在とされています。\nキュウビは、日本の古典『竹取物語』や『伊勢物語』、『物語シリーズ』などの文学作品や、絵画、浮世絵、能や歌舞伎などの芸術作品にも登場します。また、キュウビをモチーフにした漫画やアニメ、ゲームなども多数制作されています。\nキュウビは、しばしば女性の姿で描かれることがあり、美しい容姿や妖艶な雰囲気が特徴的です。また、知恵や力を持ち、時には人間界に干渉して事件を引き起こすこともあります。\n日本の神話では、キュウビはしばしば天照大神（あまてらすおおみかみ）を始めとする神々と関わり、物語の展開に大きな影響を与える存在として描かれています。"
    ],
    "king": [
        "Name": "king",
        "No": 16,
        "HP": UserDefaults.standard.double(forKey: "taskTime") > 60 ? UserDefaults.standard.double(forKey: "taskTime") * 7 * 2.0 : 420,
        "ExpRatio": [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 1.0],
        "Images": [
            "egg-rainbow-1",
            "egg-rainbow-2",
            "egg-rainbow-3",
            "s-rainbow-1",
            "s-rainbow-2",
            "s-rainbow-3",
            "King-1",
            "King-2-3",
            "King-3"
        ],
        "PhaseName": [
            "虹色の卵",
            "少し割れた虹色の卵",
            "かなり割れた虹色の卵",
            "虹色の子スライム",
            "虹色の青年スライム",
            "虹色の成人スライム",
            "王冠を形成するスライム",
            "王子",
            "王"
        ],
//        "Detail": "　「堺の右では子供が飢えて死に、左では何もしないクズが全てを持っている。\n\n　狂気の沙汰だ。\n\n　余が壊してやる。そして与えよう。平等とはいえぬまでも理不尽な差の無い世界を。」\n\n (Hunter×Hunterより、蟻の王メルエム)"
        "Detail": "　その圧倒的な知性と野望で自国を天下無敵の国家へと導いた。自他共に認める実力至上主義であり、知も才もない者が血のつながりや人脈のみで分不相応な地位に就くことに計り知れない嫌悪感を抱く。しかし、実力とは単に実績や肉体の強さのみに起因するものではなく、人望や精神的な強さの重要性も理解しており、圧倒的な個による統治よりも、洗練された集団による統治を好む。そんな彼に人々は深い尊敬と畏敬の念を抱き、「 王 」と呼ばれ、語り継がれた。"
    ],
    "kagutsuchi": [
        "Name": "kagutsuchi",
        "No": 17,
        "HP": UserDefaults.standard.double(forKey: "taskTime") > 60 ? UserDefaults.standard.double(forKey: "taskTime") * 7 * 2.0 : 420,
        "ExpRatio": [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 1.0],
        "Images": [
            "egg-rainbow-1",
            "egg-rainbow-2",
            "egg-rainbow-3",
            "s-red-1",
            "s-red-2",
            "s-red-3",
            "Kagutsuchi-1",
            "Kagutsuchi-2-1",
            "Kagutsuchi-3"
        ],
        "PhaseName": [
            "虹色の卵",
            "少し割れた虹色の卵",
            "かなり割れた虹色の卵",
            "赤色の子スライム",
            "赤色の青年スライム",
            "赤色の成人スライム",
            "火の子",
            "カグツチ",
            "火の神 カグツチ"
        ],
        "Detail": "　古代、日本には自然界の中でも熱く、美しく、同時に危険な火の力を司る神がいました。その名は、カグツチ（軻遇突智）と言います。\nカグツチは、火山の噴火や、燃え上がる炎、暑い夏の日差し、そして人々の情熱や怒りなど、あらゆる熱の根源的なエネルギーを司っていました。彼は、美しい火の踊りを披露し、人々を魅了する一方で、その力が暴走すると、破壊や災厄をもたらすこともありました。"
    ],

    // MARK: - 都道府県
    "saitama": [
        "Name": "saitama",
        "No": 10,
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
        "No": 11,
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
        "No": 12,
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
        "No": 13,
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
        "No": 14,
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
