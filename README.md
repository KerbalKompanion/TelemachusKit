<h1 align="center">Welcome to TelemachusSwift 👋</h1>
<p>
  <a href="https://github.com/noahkamara/TelemachusSwift/releases/latest" target="_blank">
    <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-blue.svg?cacheSeconds=2592000" />
  </a>
  <a href="https://github.com/noahkamara/TelemachusSwift/wiki" target="_blank">
    <img alt="Documentation" src="https://img.shields.io/badge/documentation-yes-brightgreen.svg" />
  </a>
  <a href="https://twitter.com/noahkamara99" target="_blank">
    <img alt="Twitter: noahkamara99" src="https://img.shields.io/twitter/follow/noahkamara99.svg?style=social" />
  </a>
</p>

> TelemachusSwift is a Swift Package to help developers build Companion-Apps and other applications for KSP's 'Telemachus' Mod. The Package provides a wrapper for the websocket of Telemachus

## Author

👤 **Noah Kamara**

* Website: noahkamara.com
* Twitter: [@noahkamara99](https://twitter.com/noahkamara99)
* Github: [@noahkamara](https://github.com/noahkamara)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!<br />Feel free to check [issues page](https://github.com/noahkamara/TelemachusSwift/issues). 

## Show your support

Give a ⭐️ if this project helped you!

## Installation
- [Package Dependency](#package-dependency)
- [Swift Package Manager](#swift-package-manager)

### Add as Package Dependency
See Apples [Documentation](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app)


### Swift Package Manager

"The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies."

To integrate `FeedKit` into your project, specify it in your `Package.swift` file:

```swift
let package = Package(
    name: "MyApp",
    dependencies: [
        .Package(url: "https://github.com/noahkamara/TelemachusSwift.git", majorVersion: 1)
    ]
)
```

Then run:

```bash
$ swift build
```

Or, alternatively:

```bash
$ swift package generate-xcodeproj
```

## Getting Started
### Initiate the Subscription Manager
To connect to the Telemachus Server just call the `connect()`method with the ip and port of the websocket. You can also declare what should happen when the client connects to a server: with the `subManager.onConnect()`method
```swift
let subManager = SubscriptionManager()
subManager.connect("127.0.0.1", 8085)
subManager.onConnect = { 
  print("connected to \(subManager.currentUrl)")
}
```
### Handle incoming Telemachus Data
To handle the incoming data:
```swift
var data: TelemachusData!
let subManager = SubscriptionManager()
subManager.onTelemachusData = { (tData: TelemachusData) in
  self.data = tData
}
```
