//
//  InputContentView.swift
//  BeautifulCapture
//
//  Created by seon.yeong on 2022/02/24.
//

import SwiftUI

private enum Category: String {
    case sentences = "문장"
    case title = "제목"
    case author = "작가"
}

struct InputContentView: View {
    @State private var sentences: String = ""
    @State private var title: String = ""
    @State private var author: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                InputComponentView(
                    title: Category.sentences.rawValue,
                    contents: $sentences
                )
                    .frame(maxHeight: 200)
                InputComponentView(
                    title: Category.title.rawValue,
                    contents: $title
                )
                    .frame(height: 30)
                InputComponentView(
                    title: Category.author.rawValue,
                    contents: $author
                )
                    .frame(height: 30)
                NavigationLink(
                    destination: CaptureContentView(
                        sentences: sentences,
                        title: title,
                        author: author
                    ), label: {
                        Text("미리보기")
                    })
                    .padding(.top, 30)
            }.padding()
        }
    }

    init() {
        UITextView.appearance().backgroundColor = .clear
    }
}

struct InputContentView_Previews: PreviewProvider {
    static var previews: some View {
        InputContentView()
    }
}
