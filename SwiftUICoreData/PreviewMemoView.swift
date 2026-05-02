//
//  PreviewMemoView.swift
//  SwiftUICoreData
//
//  Created by Hiromichi Sase on 2026/05/02.
//

import SwiftUI

struct PreviewMemoView: View {
    @ObservedObject var memo: Memo

    var body: some View {
        NavigationStack() {
            VStack(alignment: .leading) {
                Text(memo.content)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
        }
    }
}

struct PreviewMemoView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let memo = Memo(context: context)
        memo.content = "Sample Content"
        return PreviewMemoView(memo: memo)
            .environment(\.managedObjectContext, context)
    }
}
