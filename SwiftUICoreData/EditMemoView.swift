//
//  EditMemoView.swift
//  SwiftUICoreData
//
//  Created by Hiromichi Sase on 2025/01/22.
//

import SwiftUI

struct EditMemoView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @State private var title: String
    @State private var content: String
    @State var path = NavigationPath()
    private var memo: Memo

    init(memo: Memo) {
        self.memo = memo
        self.title = memo.title
        self.content = memo.content
    }

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                TextView(text: $content)
                    .border(Color.green)
            }
            .padding()
        }
        .navigationTitle($title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Save") {
                    memo.title = title
                    memo.content = content

                    try? viewContext.save()
                    presentation.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct EditMemoView_Previews: PreviewProvider {
    static var previews: some View {
        EditMemoView(memo: Memo(context: PersistenceController.preview.container.viewContext))
    }
}
