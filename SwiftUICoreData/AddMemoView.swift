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
        NavigationView {
            VStack {
                TextField("Title", text: $title)
                    .border(Color.blue)
                    .modifier(TextFieldClearButton(text: $title))
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextView(text: $content)
                    .border(Color.blue)
            }
            .padding()
        }
        .navigationTitle(Text("Add memo"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Save") {
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
        }
    }
}

struct AddMemoView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemoView()
    }
}
