//
//  ContentView.swift
//  BudgetManager
//
//  Created by Wiktor Bramer on 25/10/2025.
//


import SwiftUI
import CoreData

    struct ContentView: View {
        @StateObject var viewModel: ExpenseViewModel
            
        @State private var title = ""
        @State private var amount = ""
        @State private var category = ""
        @State private var paymentType = ""
            
            var body: some View {
                NavigationView {
                    VStack {
                        List {
                            ForEach(viewModel.expenses) { expense in
                                VStack(alignment: .leading) {
                                    Text(expense.title ?? "Brak tytułu")
                                        .font(.headline)
                                    Text("Kwota: \(expense.amount)")
                                    Text("Kategoria: \(expense.category ?? "")")
                                    Text("Płatność: \(expense.paymentType ?? "")")
                                }
                            }
                        }
                    }
                    
                }
                
                
            }
        }

class ExpenseViewMock: ExpenseViewModel {
    init(){
        super.init(context: PersistenceController.shared.container.viewContext)
    }
}

#Preview {
    ContentView(viewModel: ExpenseViewMock())
}
