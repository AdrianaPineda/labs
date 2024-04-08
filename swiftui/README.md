# SwiftUI
An experiment to illustrate SwiftUI usage in Xcode. For this particular lab, I'll show how to pass info from a parent view to a detail view and back from the detail view to the parent one.


## Description

`HomeView` shows a list of accounts and it allows the user to edit each individual account. For this purpose, when a user selects an account to edit, a `DetailView` is shown which requires two properties when being instantiated

```swift
struct DetailView: View {
    @State var account: Account
    @Binding var originalAccount: Account
    // ...
}
```

1. The property `account` will be used to show the account details. Its contents will be updated when the user changes them in the form. `HomeView` won't be aware of changes on this property
2. The property `originalAccount` will be used to pass down the updated values to the `HomeView`. We use `@Binding` to make sure the `HomeView` is aware of changes happening on the `DetailView`. 

Both properties are needed because the user can cancel editing the account, and the `originalAccount` needs to be unmodified. If we keep a single @Binding property, the `HomeView` will receive changes that are not necessarily final. Therefore, it is only when the user saves the changes that the `originalAccount` is updated which, in turn, updates the account in `HoweView`

Below, is how we update `originalAccount` with the values from `account` when the user has clicked on the "Save" button

```swift
struct DetailView: View {
    var body: some View {
        // ...
        ToolbarItem(placement: .navigationBarTrailing) {
            Button("Save") {
                originalAccount = $account.wrappedValue
            }
        }
    }
}
```

## Demo

Demo of editing accounts and passing back the edited account to the parent view. Accounts are only updated if the user clicks "Save" and changes are discarded if the user clicks "Cancel" instead



https://github.com/AdrianaPineda/labs/assets/3411265/efcb0b84-2978-4ddb-9b43-cfb0a38fbfd0




## References

* [Pass data in swiftui](https://byby.dev/swiftui-data-passing)
* [Pass selected item back to parent view](https://stackoverflow.com/questions/74814270/swiftui-how-to-pass-selected-item-back-to-parent-using-viewmodels)
