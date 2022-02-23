//
//  ContentView.swift
//  BeautifulCapture
//
//  Created by seon.yeong on 2022/02/22.
//

import SwiftUI

struct ContentView: View {
    @State private var takePicture = false

    var body: some View {
        VStack(alignment: .trailing) {
            Button("이미지로 저장") {
                takePicture.toggle()
            }
                .padding(.trailing, 10)
            targetView
        }
    }

    var targetView: some View {
        InnerContentView(takePicture: $takePicture)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func takeScreenshot(origin: CGPoint, size: CGSize) -> UIImage {
        let window = UIWindow(frame: CGRect(origin: origin, size: size))
        let hosting = UIHostingController(rootView: self)
        hosting.view.frame = window.frame
        window.addSubview(hosting.view)
        window.makeKeyAndVisible()
        return hosting.view.renderedImage
    }

    func readFrame(_ onChange: @escaping (CGRect) -> Void) -> some View {
        background(
            GeometryReader { geometry in
                Color.clear
                    .preference(
                        key: FramePreferenceKey.self,
                        value: .init(origin: geometry.frame(in: .global).origin, size: geometry.size))
            }
        ).onPreferenceChange(FramePreferenceKey.self, perform: onChange)
    }
}

private struct FramePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {

    }
}
