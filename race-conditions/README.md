# Race conditions

An experiment to illustrate race condition prevention with Swift's [new concurrency API](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/)

## Description

Taking [this post](https://www.swiftbysundell.com/articles/avoiding-race-conditions-in-swift/) as a guide, this repo explores how to avoid race conditions on Swift. 

### Avoid duplicate requests
By caching the current request [`cachedLoginRequest`](https://github.com/AdrianaPineda/labs/blob/main/race-conditions/RaceConditions/RaceConditions/Login/LoginService.swift#L35) we guarantee no requests for the same username and password are executed at the same time

```swift
private var cachedLoginRequest: (payload: LoginPayload, request: DataRequest)?

func login(username: String, password: String) async throws -> LoginResponse {
    print("login-service/login")

    let payload = LoginPayload(username: username, password: password)
    let loginRequest: DataRequest
    if let cachedLoginRequest, cachedLoginRequest.payload == payload {
        // 1 - Use cached request
        loginRequest = cachedLoginRequest.request
    } else {
        // 2- If there's an existing request, cancel it
        cachedLoginRequest?.request.cancel()
        // 3 - Create a new request
        loginRequest = sendRequest(payload: payload)
    }
    
    // 4- Update cache
    cachedLoginRequest = (payload, loginRequest)
    return try await login(using: loginRequest)
}
```

1. **Use cached request**: if there is already a request with the same payload (username and password) we use that one
1. **If there's an existing request, cancel it**: at this point, if the cached request is not nil it means the previous request was made with a different payload and we need to invalidate it
1. **Create a new request**: create a new Alamofire request
1. **Update cache**: to reflect the most updated request. For simplicity, if it was already cached (i.e. the flow went through the first condition - step 1), we are assigning the same value

### Avoid multiple threads

Quoting [the post](https://www.swiftbysundell.com/articles/avoiding-race-conditions-in-swift/#thread-safety):
```
As long as our code is executing within the same thread, we can rely on the data that we read and write from our objects' properties to be correct. However, as soon as we introduce multi-threaded concurrency, two threads might end up reading or writing to the same property at the exact same time - resulting in one of the threads' data becoming immediately outdated.
```

Because of this, we need to guarantee the thread-safety. Since we are using Swift's new concurrency API, we can rely on [`Actors`](https://medium.com/@gauravborole/swift-actor-new-concurrency-feature-2af6fc5d9ed4) to make sure only one task is executed at a time. 

```swift
actor LoginService: LoginServiceProtocol {
    ...
}
```

Actors have a built-in synchronization mechanism that ensures only one task at a time can access the actor's methods, making the code inherently thread-safe