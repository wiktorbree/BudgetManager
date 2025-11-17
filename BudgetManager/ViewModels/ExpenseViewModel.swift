//
//  ExpenseViewModel.swift
//  BudgetManager
//
//  Created by Wiktor Bramer on 25/10/2025.
//

import Foundation
import CoreData
import Combine

@MainActor
class ExpenseViewModel: ObservableObject {
    
    @Published var expenses: [Expense] = []
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchExpenses()
    }
    
    func fetchExpenses() {
        let request: NSFetchRequest<Expense> = Expense.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "date", ascending: false)
        ]
        
        do {
            expenses = try context.fetch(request)
        } catch {
            print("Fetch error: \(error)")
        }
        
    }
    
    func addExpense(title: String, amount: Double, date: Date = Date(), category: String, paymentType: String) {
        
        let newExpense = Expense(context: context)
        newExpense.id = UUID()
        newExpense.title = title
        newExpense.amount = amount
        newExpense.date = date
        newExpense.category = category
        newExpense.paymentType = paymentType
        
        save()
        fetchExpenses()
        
    }
    
    func deleteExpense(_ expense: Expense) {
        context.delete(expense)
        save()
        fetchExpenses()
    }
    
    private func save() {
        do {
            try context.save()
        } catch {
            print("Save error: \(error)")
        }
    }
    
}
