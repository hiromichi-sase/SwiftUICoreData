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
    @State private var showDialog: Bool = false
    private var memo: Memo

    init(memo: Memo) {
        self.memo = memo
        self.title = memo.title ?? ""
        self.content = memo.content ?? ""
    }

    var body: some View {
        VStack {
            TextField("Title", text: $title)
                .padding(EdgeInsets(top: .zero, leading: 10.0, bottom: .zero, trailing: 10.0))
                .border(Color.gray)

            TextField("Content", text: $content)
                .padding(EdgeInsets(top: .zero, leading: 10.0, bottom: .zero, trailing: 10.0))
                .border(Color.gray)

            Spacer()

            Button("Save") {
                if title.isEmpty {
                    showDialog = true
                    return
                }

                memo.title = title
                memo.content = content

                try? viewContext.save()
                presentation.wrappedValue.dismiss()
            }
            .buttonStyle(.bordered)
            .tint(.green)
            .alert(isPresented: $showDialog) {
                Alert(title: Text("Title is empty"), message: Text("Please input title."))
            }
        }
        .padding()
    }
}

struct EditMemoView_Previews: PreviewProvider {
    static var previews: some View {
        EditMemoView(memo: Memo(context: PersistenceController.preview.container.viewContext))
    }
}
