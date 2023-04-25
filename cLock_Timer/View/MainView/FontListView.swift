//
//  FontListView.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/04/24.
//

import SwiftUI

struct FontListView: View {
    @EnvironmentObject var timeManager: TimeManager
    @Environment(\.dismiss) var dismiss
    
    // Font一覧
    struct Fonts: Identifiable {
        var id = UUID()     // ユニークなIDを自動で設定
        var fontName : String
        var customFlag: Bool
    }
    @State private var fontList = [
        Fonts(fontName: "monospace", customFlag: false),
        Fonts(fontName: "VCR OSD Mono", customFlag: true),
        Fonts(fontName: "Computo Monospace", customFlag: true),
        Fonts(fontName: "Digital-7 Mono", customFlag: true),
        Fonts(fontName: "Digital-7MonoItalic", customFlag: true),
        Fonts(fontName: "Major Mono Display", customFlag: true),
        Fonts(fontName: "Iceberg", customFlag: true),
        Fonts(fontName: "Digital Numbers", customFlag: true),
        Fonts(fontName: "IBM 3270 Semi-Narrow", customFlag: true),
        Fonts(fontName: "IBM 3270 Narrow", customFlag: true),
        Fonts(fontName: "IBM 3270", customFlag: true),
        Fonts(fontName: "Libertinus Mono", customFlag: true),
        Fonts(fontName: "Static-Regular", customFlag: true),
        Fonts(fontName: "Static-Italic", customFlag: true),
        Fonts(fontName: "Static-Bold", customFlag: true),
        Fonts(fontName: "Static-BoldItalic", customFlag: true),
        Fonts(fontName: "TaurusMonoStencilDistress", customFlag: true),
        Fonts(fontName: "TaurusMonoStencilDistress-Bold", customFlag: true),
        Fonts(fontName: "TaurusMonoStencil", customFlag: true),
        Fonts(fontName: "TaurusMonoStencil-Bold", customFlag: true),
        Fonts(fontName: "TaurusMonoOutline", customFlag: true),
        Fonts(fontName: "TaurusMonoOutline-Bold", customFlag: true),
        Fonts(fontName: "TaurusMonoDistress", customFlag: true),
        Fonts(fontName: "TaurusMonoDistress-Bold", customFlag: true),
        Fonts(fontName: "TaurusMono", customFlag: true),
        Fonts(fontName: "TaurusMono-Bold", customFlag: true),

        
        Fonts(fontName: "Courier", customFlag: false),
        Fonts(fontName: "Menlo", customFlag: false),
        Fonts(fontName: "Copperplate-Light", customFlag: false),
        Fonts(fontName: "HelveticaNeue", customFlag: false),
        //Fonts(fontName: "DBLCDTempBlack", customFlag: false),
        Fonts(fontName: "Chalkduster", customFlag: false),
        Fonts(fontName: "GillSans-UltraBold", customFlag: false),
        //Fonts(fontName: "Noteworthy-Light", customFlag: false),
//        Fonts(fontName: "MarkerFelt-Thin", customFlag: false),
//        Fonts(fontName: "MarkerFelt-Wide", customFlag: false),
        //Fonts(fontName: "HoeflerText-Regular", customFlag: false),
        //Fonts(fontName: "hoeflerText-Black", customFlag: false),
        //Fonts(fontName: "AcademyEngravedLetPlain", customFlag: false)
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(fontList) { font in
                    Button(action: {
                        let impactLight = UIImpactFeedbackGenerator(style: .light)
                        impactLight.impactOccurred()
                        
                        self.timeManager.selectedFontName = font.fontName
                    }){
                        if font.fontName == self.timeManager.selectedFontName {
                            HStack {
                                Image(systemName: "checkmark")
                                Text(font.fontName)
                                    .font(returnFont(fontName: font.fontName, fontSize: 17))
                                Spacer()
                                Text("12:34")
                                    .font(returnFont(fontName: font.fontName, fontSize: 20))
                            }
                            
                        } else {
                            HStack {
                                Text(font.fontName)
                                    .font(returnFont(fontName: font.fontName, fontSize: 17))
                                Spacer()
                                Text("12:34")
                                    .font(returnFont(fontName: font.fontName, fontSize: 20))
                            }
                        }
                    }
                }
            }
            .navigationTitle("Font")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        dismiss()
                    }){
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .foregroundColor(Color.gray)
                            .frame(width: 30, height: 30)
                    }
            )
        }
    }
    
    // FontをFontの名前から返す。等間隔フォントのみ特殊なフォントなため、条件分岐。
    private func returnFont(fontName: String, fontSize: CGFloat) -> Font {
        var name = fontName
        if name == "monospace" {
            let font = Font(UIFont.monospacedDigitSystemFont(ofSize: fontSize, weight: .medium))
            return font
        } else {
            if name.isEmpty {
                name = "monospace"
                print("ERROR FOntListView() name is Empty")
            }
            let font = Font(UIFont(name: name, size: fontSize) ?? UIFont(name: "monospace", size: 17)!)
            return font
        }
    }
}

struct FontListView_Previews: PreviewProvider {
    static var previews: some View {
        FontListView()
            .environmentObject(TimeManager())

    }
}
