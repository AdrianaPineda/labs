# SwiftData
An experiment to illustrate SwiftData usage in Xcode.

I used [this tutorial](https://www.hackingwithswift.com/books/ios-swiftui/editing-swiftdata-model-objects) as a guide

## Description

[SwiftData enables us to add persistence to the app quickly](https://developer.apple.com/documentation/swiftdata), with minimal code and no external dependencies.

Key elements:

1. `@Model`: keyword used for object models that will be stored and shown in the UI
1. `@Bindable`: keyword used to bind the object models in the UI (it shows current model state and updates if needed).
1. `@Query`: keyword to query object models from persistence
1. `@State`: keyword used to hold the path of the navigation. It will allow us to navigate to the edit view of the object

For this lab, we will model acccounts (ie containers for users ). Here are the key elements:

### Model

An `Account` that has a name, description and currency

```swift
enum AccountCurrency: String, Codable, CaseIterable {
    case USD, CAD
}

@Model class Account {
    var name: String
    var accountDescription: String
    var currency: AccountCurrency

    init(
        name: String,
        accountDescription: String,
        currency: AccountCurrency
    ) {
        self.name = name
        self.accountDescription = accountDescription
        self.currency = currency
    }
}
```

### Bindable

In order edit an `Account`, we have a bindable property on the edit view, which will show the current model state and update it if the user makes any changes. It's no different from editing an observable class

```swift
struct EditAccountView: View {
    @Bindable var account: Account // binds the model
    
    var body: some View {
    Form {
        TextField("Name", text: $account.name) // accessing the model's properties
        ...
    }
    ...
}
```

### Query

In order to list the `Account`s in the home view, we query them from persistence

```swift
struct AccountsHomeView: View {
    @Query var accounts: [Account] // accounts stored
    ...
}
```

### State

In order to navigate to the `Account` detail, we store a reference to the path in the navigation:

```swift
struct AccountsHomeView: View {
    @State private var path = [Account]() // initialized empty, and will be updated when navigating to the detail view
    ...
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
        path = [account] // Adds the new account to the path, and the UI navigates to the detail view
    }
}
```

## Demo

Demo of adding and editing accounts. Model is automatically stored in the device and reloaded when reopening the app

https://github.com/AdrianaPineda/labs/assets/3411265/61ef904f-2ed0-4da5-8d6b-fb6fda0540e2

## References
From a series of videos from Paul Hudson
* [Edit SwiftData model objects](https://www.hackingwithswift.com/books/ios-swiftui/editing-swiftdata-model-objects)
* [Query SwiftData objects in SwiftUI](https://www.hackingwithswift.com/quick-start/swiftdata/querying-swiftdata-objects-in-swiftui)
* [Create, edit and delete model objects](https://www.hackingwithswift.com/quick-start/swiftdata/creating-editing-and-deleting-model-objects)
