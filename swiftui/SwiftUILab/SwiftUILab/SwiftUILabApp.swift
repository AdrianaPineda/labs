//
//  SwiftUILabApp.swift
//  SwiftUILab
//
//  Created by Adriana Pineda on 4/7/24.
//

import SwiftUI

@main
struct SwiftUILabApp: App {
    let firstAccount = Account(name: "account 1", accountDescription: "description 1", currency: .CAD)
    let secondAccount = Account(name: "account 2", accountDescription: "description 2", currency: .USD)

    var body: some Scene {
        WindowGroup {
            HomeView(accounts: [firstAccount, secondAccount])
        }
    }
}
