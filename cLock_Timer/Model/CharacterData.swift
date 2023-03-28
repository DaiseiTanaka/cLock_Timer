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
        "HP": UserDefaults.standard.double(forKey: "taskTime") * 7 * 0.5,
        "ExpRatio": [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8],
        "Images": [
            "egg-white-1",
            "egg-white-2",
            "egg-white-3",
            "s-red-1",
            "s-red-2",
            "s-red-3",
            "Rabit-1",
            "Rabit-2",
            "Rabit-3"
        ]
    ],
    "frog": [
        "Name": "Frog",
        "HP": UserDefaults.standard.double(forKey: "taskTime") * 7 * 0.75,
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
        ]
    ],
    "chicken": [
        "Name": "Chicken",
        "HP": UserDefaults.standard.double(forKey: "taskTime") * 7 * 1.0,
        "ExpRatio": [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8],
        "Images": [
            "egg-brown-1",
            "egg-brown-1",
            "egg-brown-3",
            "s-red-1",
            "s-red-2",
            "s-red-3",
            "Chicken-1",
            "Chicken-2",
            "Chicken-3"
        ]
    ],
    "unicorn": [
        "Name": "Unicorn",
        "HP": UserDefaults.standard.double(forKey: "taskTime") * 7 * 1.25,
        "ExpRatio": [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.9],
        "Images": [
            "egg-rainbow-1",
            "egg-rainbow-2",
            "egg-rainbow-3",
            "s-black-1",
            "s-rainbow-2",
            "s-rainbow-3",
            "Unicorn-1",
            "Unicorn-2",
            "Unicorn-3"
        ]
    ],
    "genger": [
        "Name": "Genger",
        "HP": UserDefaults.standard.double(forKey: "taskTime") * 7 * 1.5,
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
        ]
    ]
]
