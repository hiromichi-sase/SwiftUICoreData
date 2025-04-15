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
    @State private var title: String = "(Title)"
    @State private var content: String = ""
    @State var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                TextView(text: $content)
                    .border(Color.blue)
            }
            .padding()
        }
        .navigationTitle($title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Save") {
                    let memo = Memo(context: viewContext)
                    memo.title = title
                    memo.content = content

                    try? viewContext.save()
                    presentation.wrappedValue.dismiss()
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
