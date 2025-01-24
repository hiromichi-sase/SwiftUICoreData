//
//  ContentView.swift
//  SwiftUICoreData
//
//  Created by Hiromichi Sase on 2025/01/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Memo.entity(),
        sortDescriptors: [NSSortDescriptor(key: "title", ascending: true)],
        animation: .default)
    private var memos: FetchedResults<Memo>
    @State private var editMode: EditMode = .inactive

    var body: some View {
        NavigationView {
            List {
                ForEach(memos) { memo in
                    NavigationLink(destination: EditMemoView(memo: memo)) {
                        VStack {
                            Text(memo.title ?? "")
                        }
                    }
                }
                .onDelete(perform: editMode.isEditing ? deleteMemo : nil)
            }
            .navigationTitle(Text("Memos"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    NavigationLink {
                        AddMemoView()
                    } label: {
                        Text("Add")
                    }
                }
            }
            .environment(\.editMode, $editMode)
        }
    }

    private func deleteMemo(offset: IndexSet) {
        offset.forEach { index in
            viewContext.delete(memos[index])
        }
        try? viewContext.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
