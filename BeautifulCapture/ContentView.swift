//
//  ContentView.swift
//  BeautifulCapture
//
//  Created by seon.yeong on 2022/02/22.
//

import SwiftUI

struct ContentView: View {
    @State private var takePicture = false
    @State private var style: Style = .first
    @State private var fontStyle: FontStyle = .seoulNamsan

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
        InnerContentView(
            takePicture: $takePicture,
            style: $style,
            fontStyle: $fontStyle
        )
    }

    var styleOptionView: some View {
        StyleOptionView(
            style: $style,
            fontStyle: $fontStyle
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
