//
//  InputComponentView.swift
//  BeautifulCapture
//
//  Created by seon.yeong on 2022/02/24.
//

import SwiftUI

struct InputComponentView: View {
    let title: String

    @Binding var contents: String

    var body: some View {
        HStack(alignment: .top) {
            Text(title)
                .foregroundColor(Color.indigo)
            TextEditor(text: $contents)
                .disableAutocorrection(true)
                .onTapGesture {
                    hideKeyboard()
                }
                .border(Color.indigo)
        }
    }
}

struct InputComponentView_Previews: PreviewProvider {
    static var previews: some View {
        InputComponentView(
            title: "Title",
            contents: .constant("Sample Contents")
        )
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
