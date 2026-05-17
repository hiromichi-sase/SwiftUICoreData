//
//  AddMemoView.swift
//  SwiftUICoreData
//
//  Created by Hiromichi Sase on 2025/01/20.
//

import SwiftUI
import CoreData

struct AddMemoView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var title: String = "(Title)"
    @State private var content: String = ""

    @State var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                TextView(text: $content, isEditable: .constant(true))
                    .border(.primary)
            }
            .padding()
        }
        .navigationTitle($title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Save") {
                    let fetchquest = NSFetchRequest<Memo>(entityName: "Memo")
                    let count = (try? viewContext.fetch(fetchquest))?.count ?? .zero

                    let memo = Memo(context: viewContext)
                    memo.id = UUID()
                    memo.title = title
                    memo.content = content
                    memo.createdAt = Date()
                    memo.updatedAt = Date()
                    memo.order = count + 1
                    try? viewContext.save()
                    dismiss()
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
