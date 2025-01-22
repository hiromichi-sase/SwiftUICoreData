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
                .padding(EdgeInsets(top: .zero, leading: 10.0, bottom: .zero, trailing: 10.0))
                .border(Color.gray)

            TextField("Content", text: $content)
                .padding(EdgeInsets(top: .zero, leading: 10.0, bottom: .zero, trailing: 10.0))
                .border(Color.gray)

            Spacer()

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
            .buttonStyle(.bordered)
            .tint(.blue)
            .alert(isPresented: $showDialog) {
                Alert(title: Text("Title is empty"), message: Text("Please input title."))
            }
        }
        .padding()
    }
}

struct AddMemoView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemoView()
    }
}
