//
//  InnerContentView.swift
//  BeautifulCapture
//
//  Created by seon.yeong on 2022/02/22.
//

import SwiftUI

private enum Placeholder: String {
    case sentences = "문장"
    case title = "제목"
    case author = "작가"
}

struct InnerContentView: View {
    @Binding var takePicture: Bool
    @Binding var style: Style
    @Binding var fontStyle: FontStyle

    @State private var sentences: String = Placeholder.sentences.rawValue
    @State private var title: String = Placeholder.title.rawValue
    @State private var author: String = Placeholder.author.rawValue
    @State private var frame: CGRect = .zero

    init(takePicture: Binding<Bool>, style: Binding<Style>, fontStyle: Binding<FontStyle>) {
        self._takePicture = takePicture
        self._style = style
        self._fontStyle = fontStyle
        UITextView.appearance().backgroundColor = .clear
    }

    var body: some View {
        VStack {
            sentencesView
            titleView
            authorView
        }
        .background {
            Image(jpegName: style.imageName).resizable()
        }
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
        TextEditor(text: $sentences)
            .font(fontStyle.settings.sentencesFont)
            .foregroundColor(style.settings.textColor)
            .padding(.top, 10)
            .lineSpacing(10)
            .disableAutocorrection(true)
            .onTapGesture {
                if self.sentences == Placeholder.sentences.rawValue {
                    self.sentences = ""
                }
            }
    }

    var titleView: some View {
        TextEditor(text: $title)
            .font(fontStyle.settings.titleFont)
            .foregroundColor(style.settings.textColor)
            .frame(maxHeight: 30)
            .disableAutocorrection(true)
            .onTapGesture {
                if self.title == Placeholder.title.rawValue {
                    self.title = ""
                }
            }
    }

    var authorView: some View {
        TextEditor(text: $author)
            .font(fontStyle.settings.authorFont)
            .foregroundColor(style.settings.subTextColor)
            .frame(maxHeight: 30)
            .padding(.bottom, 10)
            .disableAutocorrection(true)
            .onTapGesture {
                if self.author == Placeholder.author.rawValue {
                    self.author = ""
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
