//
//  Style.swift
//  BeautifulCapture
//
//  Created by seon.yeong on 2022/02/23.
//

import SwiftUI

struct ColorStyle {
    var imageName: String
    var textColor: Color?
    var subTextColor: Color?
}

struct FontStyle {
    var sentencesFont: Font?
    var titleFont: Font?
    var authorFont: Font?
}

enum BackgroundOption: Int, CaseIterable {
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

    var style: ColorStyle {
        ColorStyle(
            imageName: imageName,
            textColor: textColor,
            subTextColor: subTextColor
        )
    }
}

enum FontOption: String, CaseIterable {
    case seoulNamsan

    var style: FontStyle {
        switch self {
        case .seoulNamsan:
            return FontStyle(
                sentencesFont: Font.custom("SeoulNamsanM", size: 18),
                titleFont: Font.custom("SeoulNamsanL", size: 15),
                authorFont: Font.custom("SeoulNamsanL", size: 15)
            )
        }
    }
}
