//
//  CaptureTargetView.swift
//  BeautifulCapture
//
//  Created by seon.yeong on 2022/02/22.
//

import SwiftUI

struct CaptureTargetView: View {
    @Binding var takePicture: Bool
    @Binding var style: Style
    @Binding var fontStyle: FontStyle

    let sentences: String
    let title: String
    let author: String

    @State private var frame: CGRect = .zero

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            sentencesView
            titleView
            authorView
                .padding(.bottom, 70)
        }
        .frame(maxWidth: .infinity)
        .padding(30)
        .modifier(StyleModifier(style: style))
        .clipped()
        .aspectRatio(1, contentMode: .fit)
        .readFrame { newValue in
            frame = newValue
        }
        .onChange(of: takePicture) { newValue in
            guard newValue else { return }
            let image = self.takeScreenshot(
                origin: frame.origin,
                size: frame.size)
            ImageCaptureManager().saveToPhotos(image)

            takePicture.toggle()
        }
    }

    var sentencesView: some View {
        HStack {
            Text(sentences)
                .font(fontStyle.settings.sentencesFont)
                .foregroundColor(style.settings.textColor)
                .lineSpacing(10)
                .frame(maxHeight: .infinity)
            Spacer()
        }
    }

    var titleView: some View {
        Text(title)
            .font(fontStyle.settings.titleFont)
            .foregroundColor(style.settings.textColor)
            .frame(maxHeight: 30)
    }

    var authorView: some View {
        Text(author)
            .font(fontStyle.settings.authorFont)
            .foregroundColor(style.settings.subTextColor)
            .frame(maxHeight: 30)
    }
}

struct CaptureTargetView_Previews: PreviewProvider {
    static var previews: some View {
        CaptureTargetView(
            takePicture: .constant(false),
            style: .constant(.first),
            fontStyle: .constant(.seoulNamsan),
            sentences: "????????? ???????????? ?????? ??????, ????????? ?????? ????????? ???????????? ????????? ??? ?????? ???????????? ?????? ?????? ?????????????????? ???????????? ????????? ??? ????????? ??????.",
            title: "?????? ?????? ???????????? ??????",
            author: "?????????"
        )
    }
}

private extension View {
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
