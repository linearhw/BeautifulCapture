//
//  CaptureContentView.swift
//  BeautifulCapture
//
//  Created by seon.yeong on 2022/02/24.
//

import SwiftUI

struct CaptureContentView: View {
    @State private var takePicture = false
    @State private var style: Style = .first
    @State private var fontStyle: FontStyle = .seoulNamsan

    let sentences: String
    let title: String
    let author: String

    var body: some View {
        VStack {
            HStack {
                Spacer()
                saveButton
            }
            targetView
            styleOptionView
        }
    }

    var saveButton: some View {
        Button("이미지로 저장") {
            takePicture.toggle()
        }
        .padding(.trailing, 10)
    }

    var targetView: some View {
        CaptureTargetView(
            takePicture: $takePicture,
            style: $style,
            fontStyle: $fontStyle,
            sentences: sentences,
            title: title,
            author: author
        )
    }

    var styleOptionView: some View {
        StyleOptionView(
            style: $style,
            fontStyle: $fontStyle
        )
    }
}

struct CaptureContentView_Previews: PreviewProvider {
    static var previews: some View {
        CaptureContentView(
            sentences: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            title: "Preview Title",
            author: "Preview Author"
        )
    }
}
