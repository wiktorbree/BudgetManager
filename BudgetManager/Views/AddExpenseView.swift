//
//  AddExpenseView.swift
//  BudgetManager
//
//  Created by Wiktor Bramer on 17/11/2025.
//

import SwiftUI
import CoreData

struct AddExpenseView: View {
    @ObservedObject var viewModel: ExpenseViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var amountText: String = ""
    @State private var date: Date = Date()
    @State private var category: String = ""
    @State private var paymentType: String = "Cash"
    
    private let categories = ["General", "Food", "Gas", "Subscriptions", "Fun", "Other"]
    private let paymentTypes = ["Cash", "Card", "BLIK"]
    
    
    var body: some View {
        NavigationStack{
            Form{
                Section() {
                    TextField("Title", text: $title)
                    
                    TextField("Amount", text: $amountText).keyboardType(.decimalPad)
                    
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
                Section("Category") {
                    Picker("General", selection: $category) {
                        ForEach(categories, id: \.self) {cat in
                            Text(cat).tag(cat)
                        }
                    }
                }
                Section("Payment Type") {
                    Picker("Card", selection: $paymentType) {
                        ForEach(paymentTypes, id: \.self) {method in
                            Text(method).tag(method)
                        }
                    }.pickerStyle(.segmented)
                }
            }
            .navigationTitle("Add Expense")
        }.toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    saveExpense()
                }
            }
        }
    }
    
    private func saveExpense() {
        // 1. sprawdź kwotę
        guard let amount = Double(amountText.replacingOccurrences(of: ",", with: ".")),
              amount > 0 else {
            print("Nieprawidłowa kwota")
            return
        }
        
        // 2. może jakaś domyślna kategoria
        let finalCategory = category.isEmpty ? "Other" : category
        
        // 3. wywołanie viewModelu
        viewModel.addExpense(
            title: title.isEmpty ? "No title" : title,
            amount: amount,
            date: date,
            category: finalCategory,
            paymentType: paymentType
        )
        
        // 4. zamknięcie widoku
        dismiss()
    }
}



class ExpenseViewModelMock: ExpenseViewModel {
    init() {
        super.init(context: PersistenceController.preview.container.viewContext)
    }
}

#Preview {
    AddExpenseView(viewModel: ExpenseViewModelMock())
}
