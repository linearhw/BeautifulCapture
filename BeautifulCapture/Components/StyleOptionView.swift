//
//  StyleOptionView.swift
//  BeautifulCapture
//
//  Created by seon.yeong on 2022/02/23.
//

import SwiftUI

struct StyleOptionView: View {
    @Binding var style: Style
    @Binding var fontStyle: FontStyle

    @State var showStyleAlert = false
    @State var showFontStyleAlert = false

    var body: some View {
        HStack {
            styleButton.frame(maxWidth: .infinity)
            fontStyleButton.frame(maxWidth: .infinity)
        }
    }

    var styleButton: some View {
        Button("스타일 바꾸기") {
            showStyleAlert = true
        }
        .alert("스타일 선택", isPresented: $showStyleAlert) {
            ForEach(Style.allCases, id: \.self) { style in
                Button("스타일 \(style.rawValue)") {
                    self.style = style
                    showStyleAlert = false
                }
            }
            Button("취소", role: .cancel) {
                showStyleAlert = false
            }
        }
    }

    var fontStyleButton: some View {
        Button("폰트 바꾸기") {
            showFontStyleAlert = true
        }
        .alert("폰트 선택", isPresented: $showFontStyleAlert) {
            ForEach(FontStyle.allCases, id: \.self) { style in
                Button(style.rawValue) {
                    self.fontStyle = style
                    showFontStyleAlert = false
                }
            }
            Button("취소", role: .cancel) {
                showFontStyleAlert = false
            }
        }
    }
}
