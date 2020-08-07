# Project 3: Views and Modifiers


Overview: https://www.hackingwithswift.com/books/ios-swiftui

## Recap

* Why structs
*     ... for SwiftUI developers, there is nothing behind our view ...
* `UIHostingController`
* Why modifier order matters
* `some View` and opaque return type
*     ... And that’s why SwiftUI doesn’t allow more than 10 views inside a parent: they wrote versions of TupleView that handle 2 views through 10, but no more ...
* View modifier (environment ones and regular ones) and custom modifier
* Custom containers and the `@ViewBuilder` attribute.



### Why modifier order matters:

```
Text("Hello World")
    .padding()
    .background(Color.red)
    .padding()
    .background(Color.blue)
    .padding()
    .background(Color.green)
    .padding()
    .background(Color.yellow)
```

## Screenshots

![](https://github.com/benjamin-wen/Hacking-with-iOS/blob/master/SwiftUI-Edition/Project-03/screenshot-01.png)

![](https://github.com/benjamin-wen/Hacking-with-iOS/blob/master/SwiftUI-Edition/Project-03/screenshot-02.png)
