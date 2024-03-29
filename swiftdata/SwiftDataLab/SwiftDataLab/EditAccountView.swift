//
//  EditAccountView.swift
//  SwiftDataLab
//
//  Created by Adriana Pineda on 3/28/24.
//

import SwiftData
import SwiftUI

struct EditAccountView: View {
    @Bindable var account: Account

    var body: some View {
        Form {
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
        }.navigationTitle("Edit Account")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let example = Account(
        name: "Test name",
        accountDescription: "Test description",
        currency: .CAD
    )
    return EditAccountView(account: example)
}
