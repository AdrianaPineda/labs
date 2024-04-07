//
//  HomeView.swift
//  SwiftUILab
//
//  Created by Adriana Pineda on 4/7/24.
//

import SwiftUI

struct HomeView: View {
    @State var accounts: [Account]
    @State private var accountToEdit: Binding<Account>?

    var body: some View {
        NavigationStack {
            List {
                ForEach($accounts) { account in
                    Text(account.name.wrappedValue).swipeActions {
                        Button("edit", role: .cancel) {
                            accountToEdit = account
                        }
                    }
                }
            }
            .navigationTitle("Accounts")
            // Edit account
            .sheet(item: $accountToEdit, content: { accountToEdit in
                buildEditAccountView(accountToEdit: accountToEdit)
            })
        }
    }

    // Edit account
    private func buildEditAccountView(accountToEdit: Binding<Account>) -> some View {
        return DetailView(
            account: accountToEdit.wrappedValue,
            originalAccount: accountToEdit
        )
    }
}

#Preview {
    let firstAccount = Account(name: "account 1", accountDescription: "description 1", currency: .CAD)
    let secondAccount = Account(name: "account 2", accountDescription: "description 2", currency: .CAD)
    return HomeView(accounts: [firstAccount, secondAccount])
}
