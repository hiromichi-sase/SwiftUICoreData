//
//  AddMemoView.swift
//  SwiftUICoreData
//
//  Created by Hiromichi Sase on 2025/01/20.
//

import SwiftUI

struct AddMemoView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var showDialog: Bool = false

    var body: some View {
        VStack {
            TextField("Title", text: $title)

            TextField("Content", text: $content)

            Button("Add") {
                if title.isEmpty {
                    showDialog = true
                    return
                }

                let memo = Memo(context: viewContext)
                memo.title = title
                memo.content = content

                try? viewContext.save()
                presentation.wrappedValue.dismiss()
            }
            .alert(isPresented: $showDialog) {
                Alert(title: Text("Title is empty"), message: Text("Please input title."))
            }
        }
        .padding()
    }
}

#Preview {
    AddMemoView()
}
