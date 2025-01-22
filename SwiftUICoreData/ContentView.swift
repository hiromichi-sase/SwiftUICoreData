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
                .onDelete(perform: deleteMemo)
            }
            .navigationTitle(Text("Memos"))
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        AddMemoView()
                    } label: {
                        Text("Add")
                    }
                }
            }
        }
    }

    private func deleteMemo(offset: IndexSet) {
        offset.forEach { index in
            viewContext.delete(memos[index])
        }
        try? viewContext.save()
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
