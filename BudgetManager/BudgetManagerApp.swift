//
//  BudgetManagerApp.swift
//  BudgetManager
//
//  Created by Wiktor Bramer on 25/10/2025.
//

import SwiftUI
import CoreData

@main
struct BudgetManagerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ExpenseViewModel(context: persistenceController.container.viewContext))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
