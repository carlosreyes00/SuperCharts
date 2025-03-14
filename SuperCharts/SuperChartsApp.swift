//
//  SuperChartsApp.swift
//  SuperCharts
//
//  Created by Carlos Reyes on 3/8/25.
//

import SwiftUI
import SwiftData

@main
struct SuperChartsApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Point.self,
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
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
