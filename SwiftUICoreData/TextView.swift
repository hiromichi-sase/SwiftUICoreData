//
//  TextView.swift
//  SwiftUICoreData
//
//  Created by Hiromichi Sase on 2025/02/05.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    @Binding var text: String

    func makeCoordinator() -> Coordinator {
        Coordinator($text)
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.font = UIFont.systemFont(ofSize: 16)
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}

class Coordinator: NSObject, UITextViewDelegate {
    var text: Binding<String>

    init(_ text: Binding<String>) {
        self.text = text
    }

    func textViewDidChange(_ textView: UITextView) {
        self.text.wrappedValue = textView.text
    }
}
