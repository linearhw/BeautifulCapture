//
//  Style.swift
//  BeautifulCapture
//
//  Created by seon.yeong on 2022/02/23.
//

import SwiftUI

struct StyleSettings {
    var imageName: String
    var textColor: Color?
    var subTextColor: Color?
}

struct FontSettings {
    var sentencesFont: Font?
    var titleFont: Font?
    var authorFont: Font?
}

enum Style: Int, CaseIterable {
    case first = 1
    case second
    case third
    case fourth

    var imageName: String {
        "background\(self.rawValue)"
    }

    var textColor: Color? {
        switch self {
        case .first:
            return .white
        case .second:
            return .white
        case .third:
            return .white
        case .fourth:
            return .white
        }
    }

    var subTextColor: Color? {
        textColor?.opacity(0.8)
    }

    var settings: StyleSettings {
        StyleSettings(
            imageName: imageName,
            textColor: textColor,
            subTextColor: subTextColor
        )
    }
}

enum FontStyle: String, CaseIterable {
    case seoulNamsan = "서울남산체"
    case koPubWorld = "KoPub 바탕체"

    var settings: FontSettings {
        switch self {
        case .seoulNamsan:
            return FontSettings(
                sentencesFont: Font.custom("SeoulNamsanM", size: 18),
                titleFont: Font.custom("SeoulNamsanL", size: 15),
                authorFont: Font.custom("SeoulNamsanL", size: 15)
            )
        case .koPubWorld:
            return FontSettings(
                sentencesFont: Font.custom("KoPubWorldBatangM", size: 18),
                titleFont: Font.custom("KoPubWorldBatangL", size: 15),
                authorFont: Font.custom("KoPubWorldBatangL", size: 15)
            )
        }
    }
}

struct StyleModifier: ViewModifier {
    var style: Style

    func body(content: Content) -> some View {
        switch style {
        case .first:
            let colors = [Color(hex: 0x4771b1), Color(hex: 0x946ccc)]
            content.background {
                LinearGradient(
                    gradient: Gradient(colors: colors),
                    startPoint: .bottomLeading,
                    endPoint: .topTrailing
                )
            }
        default:
            content.background {
                Image(jpegName: style.imageName).resizable()
            }
        }
    }
}

private extension Image {
    init(jpegName: String) {
        guard
            let url = Bundle.main.url(forResource: jpegName, withExtension: "jpeg"),
            let image = UIImage(contentsOfFile: url.path) else {
            self.init(jpegName)
            return
        }
        self.init(uiImage: image)
    }
}

private extension Color {
    init(hex: UInt, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}
