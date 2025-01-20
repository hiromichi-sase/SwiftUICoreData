//
//  SwiftUICoreDataApp.swift
//  SwiftUICoreData
//
//  Created by Hiromichi Sase on 2025/01/20.
//

import SwiftUI

@main
struct SwiftUICoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
