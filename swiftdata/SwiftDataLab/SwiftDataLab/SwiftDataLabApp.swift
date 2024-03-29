//
//  SwiftDataLabApp.swift
//  SwiftDataLab
//
//  Created by Adriana Pineda on 3/28/24.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataLabApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Account.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            AccountsHomeView()
        }
        .modelContainer(sharedModelContainer)
    }
}
