//
//  CharacterData.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/03/28.
//

import SwiftUI

let CharacterData: [String : Any] = [
    "rabit": [
        "Name": "Rabit",
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
        ]
    ],
    "frog": [
        "Name": "Frog",
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
        ]
    ],
    "chicken": [
        "Name": "Chicken",
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
        ]
    ],
    "unicorn": [
        "Name": "Unicorn",
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
        ]
    ],
    "genger": [
        "Name": "Genger",
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
        ]
    ],
    // MARK: - 都道府県
    "saitama": [
        "Name": "SAITAMA",
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
        ]
    ],
    "tokyo": [
        "Name": "TOKYO",
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
        ]
    ],
    "kagagawa": [
        "Name": "KANAGAWA",
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
        ]
    ],
    "yamanashi": [
        "Name": "YAMANASHI",
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
        ]
    ],
    "shizuoka": [
        "Name": "SHIZUOKA",
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
        ]
    ]
]
