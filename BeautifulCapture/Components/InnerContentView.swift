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

    @State private var sentences: String = Placeholder.sentences.rawValue
    @State private var title: String = Placeholder.title.rawValue
    @State private var author: String = Placeholder.author.rawValue
    @State private var colorStyle = BackgroundOption.first.style
    @State private var fontStyle = FontOption.seoulNamsan.style
    @State private var frame: CGRect = .zero

    init(takePicture: Binding<Bool>) {
        self._takePicture = takePicture
        UITextView.appearance().backgroundColor = .clear
    }

    var body: some View {
        VStack {
            sentencesView
            titleView
            authorView
        }
        .background {
            Image(jpegName: colorStyle.imageName).resizable()
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
            .font(fontStyle.sentencesFont)
            .foregroundColor(colorStyle.textColor)
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
            .font(fontStyle.titleFont)
            .foregroundColor(colorStyle.textColor)
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
            .font(fontStyle.authorFont)
            .foregroundColor(colorStyle.subTextColor)
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

extension Image {
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
