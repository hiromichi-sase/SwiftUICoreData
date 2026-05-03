//
//  EditMemoView.swift
//  SwiftUICoreData
//
//  Created by Hiromichi Sase on 2025/01/22.
//

import SwiftUI

struct EditMemoView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject private var memo: Memo

    @State private var title: String
    @State private var content: String

    @State var path = NavigationPath()
    @State var disabled: Bool

    init(memo: Memo, disabled: Bool) {
        self._memo = ObservedObject(initialValue: memo)
        self._title = State(initialValue: memo.title)
        self._content = State(initialValue: memo.content)
        self._disabled = State(initialValue: disabled)
    }

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                TextView(text: $content, isEditable: .constant(!disabled))
                    .border(disabled ? .clear : .primary)
            }
            .padding()
            .onReceive(memo.objectWillChange) { _ in
                guard disabled else { return }
                title = memo.title
                content = memo.content
            }
        }
        .navigationTitle($title, disabled: disabled)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(!disabled)
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                if !disabled {
                    Button("Cancel") {
                        disabled = true
                    }
                }
            }
            ToolbarItemGroup(placement: .topBarTrailing) {
                if disabled {
                    Button("Edit") {
                        disabled = false
                    }
                } else {
                    Button("Save") {
                        guard !disabled else { return }
                        memo.title = title
                        memo.content = content
                        try? viewContext.save()
                        disabled = true
                    }
                }

            }
        }
    }
}

struct Disabled_True_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let memo = Memo(context: context)
        memo.content = "Sample Content"
        return NavigationStack {
            EditMemoView(memo: memo, disabled: true)
                .environment(\.managedObjectContext, context)
        }
    }
}

struct Disabled_False_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let memo = Memo(context: context)
        memo.content = "Sample Content"
        return NavigationStack {
            EditMemoView(memo: memo, disabled: false)
                .environment(\.managedObjectContext, context)
        }
    }
}
