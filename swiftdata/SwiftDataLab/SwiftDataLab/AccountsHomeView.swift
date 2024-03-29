//
//  AccountsHomeView.swift
//  SwiftDataLab
//
//  Created by Adriana Pineda on 3/28/24.
//

import SwiftData
import SwiftUI

struct AccountsHomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var accounts: [Account]
    @State private var path = [Account]()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(accounts) { account in
                    NavigationLink(value: account) {
                        Text(account.name)
                    }
                }
            }
            .navigationTitle("Accounts")
            .navigationDestination(for: Account.self, destination: EditAccountView.init)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addAccount) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }

    func addAccount() {
        let account = Account(name: "", accountDescription: "", currency: .CAD)
        modelContext.insert(account)
        path = [account]
    }
}

#Preview {
    AccountsHomeView().modelContainer(for: Account.self, inMemory: true)
}

