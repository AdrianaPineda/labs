//
//  DetailView.swift
//  SwiftUILab
//
//  Created by Adriana Pineda on 4/7/24.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State var account: Account
    @Binding var originalAccount: Account

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    TextField("Name", text: $account.name)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.sentences)
                    TextField("Description", text: $account.accountDescription)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.sentences)
                    Picker("Currency", selection: $account.currency) {
                        ForEach(AccountCurrency.allCases, id: \.self) { currency in
                            Text(currency.rawValue).tag(currency)
                        }
                    }.pickerStyle(.segmented)
                }
            }
        .navigationBarTitle("Edit Account")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        originalAccount = $account.wrappedValue
                        dismiss()
                    }.onAppear {
                        originalAccount = $account.wrappedValue
                    }
                }
            }
        }
    }
}

#Preview {
    let account = Account(
        name: "Test name",
        accountDescription: "Test description",
        currency: .CAD
    )
    let originalAccount: Binding<Account> = Binding(get: { account }, set: { _ in })
    return DetailView(account: account, originalAccount: originalAccount)
}
