//
//  ImageSaver.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/04/01.
//

import SwiftUI

class ImageSaver: NSObject {
    @Binding var showAlert: Bool
    
    init(_ showAlert: Binding<Bool>) {
        _showAlert = showAlert
    }
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(didFinishSavingImage), nil)
    }

    @objc func didFinishSavingImage(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
        if error != nil {
            print("画像の保存に失敗しました。")
        } else {
            //showAlert = true
        }
    }
}
