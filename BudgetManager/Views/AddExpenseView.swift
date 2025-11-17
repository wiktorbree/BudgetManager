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
    
    @State private var title: String = ""
    @State private var amountText: String = ""
    @State private var date: Date = Date()
    @State private var category: String = ""
    @State private var paymentType: String = "Gotówka"
    
    let categories = ["General", "Food", "Gas", "Subscriptions", "Fun", "Other"]
    let paymentTypes = ["Cash", "Card", "BLIK"]
    
    
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
        }
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
