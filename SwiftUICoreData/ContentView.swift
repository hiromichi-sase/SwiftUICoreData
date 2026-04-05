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
    @State private var memoToDelete: Memo?
    @State private var memoToPush: Memo?
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(memos) { memo in
                    Button {
                        if editMode == .inactive {
                            memoToPush = memo
                        }
                    } label: {
                        Text(memo.title)
                    }
                    .tint(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
                    .contextMenu {
                        if editMode == .inactive {
                            Button("Edit") {
                                memoToPush = memo
                            }
                            Button("Delete", role: .destructive) {
                                memoToDelete = memo
                            }
                        }
                    } preview: {
                        if editMode == .inactive {
                            EditMemoView(memo: memo, disabled: true)
                        }
                    }
                }
                .onDelete(perform: showDeleteAlert)
                .alert(item: $memoToDelete) { memo in
                    Alert(title: Text("Delete this memo?"),
                          primaryButton: .destructive(Text("Delete")) {
                        deleteMemo(memo: memo)
                    }, secondaryButton: .cancel())
                }
            }
            .navigationDestination(item: $memoToPush) { memo in
                EditMemoView(memo: memo, disabled: false)
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
            memoToDelete = memos[offset]
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
