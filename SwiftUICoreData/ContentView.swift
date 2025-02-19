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
    @State var memo: Memo?
    @State var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(memos) { memo in
                    NavigationLink(destination: EditMemoView(memo: memo)) {
                        Text(memo.title ?? "")
                    }
                }
                .onDelete(perform: showDeleteAlert)
                .alert(item: $memo) { memo in
                    Alert(title: Text("Delete this memo?"),
                          primaryButton: .destructive(Text("Delete")) {
                        deleteMemo(memo: memo)
                    }, secondaryButton: .cancel())
                }
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

    private func showDeleteAlert(offsets: IndexSet) {
        if let offset = offsets.first {
            memo = memos[offset]
        }
    }

    private func deleteMemo(memo: Memo) {
        viewContext.delete(memo)
        try? viewContext.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
