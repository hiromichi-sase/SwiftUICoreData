//
//  TextFieldClearButton.swift
//  SwiftUICoreData
//
//  Created by Hiromichi Sase on 2025/02/13.
//

import SwiftUI

struct TextFieldClearButton: ViewModifier {
    @Binding var text: String

    func body(content: Self.Content) -> some View {
        ZStack(alignment: .trailing) {
            content
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "multiply.circle")
                        .foregroundColor(.secondary)
                }
                .padding(.trailing, 8)
                .padding(.vertical, 6)
            }
        }
    }
}
