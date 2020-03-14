<h1 align="center">Welcome to TelemachusKit 👋</h1>
<p>
  <a href="https://github.com/noahkamara/TelemachusKit/releases/latest">
    <img alt="latest stable" src="https://img.shields.io/github/v/release/noahkamara/TelemachusSwift?label=stable">
  </a>
  <a href="https://github.com/noahkamara/TelemachusKit/releases/latest">
    <img alt="latest version" src="https://img.shields.io/github/v/release/noahkamara/TelemachusSwift?include_prereleases&label=pre">
  </a>
  <a href="https://noahkamara.github.io/TelemachusKit/index.html" target="_blank">
    <img alt="Documentation" src="https://img.shields.io/badge/documentation-yes-brightgreen.svg" />
  </a>
  <a href="https://github.com/noahkamara/TelemachusKit/blob/master/LICENSE">
    <img src="https://img.shields.io/github/license/noahkamara/TelemachusKit" />
  </a>
  <a href="https://github.com/TeleIO/Telemachus-1/releases">
    <img src="https://img.shields.io/badge/Telemachus-1.7-lightgrey" />
  </a>
</p>



> TelemachusKit is a Swift Package to help developers build Companion-Apps and other applications for KSP's 'Telemachus' Mod. The Package provides a wrapper for the websocket of Telemachus

- [Author](#author)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [Recommended KSP and Telemachus Versions](#recommended-ksp-and-telemachus-versions)
- [Installation Instructions](#installation)
- [Getting Started](#getting-started)

## Author

👤 **Noah Kamara**

* Website: noahkamara.com
* Twitter: [@noahkamara99](https://twitter.com/noahkamara99)
* Github: [@noahkamara](https://github.com/noahkamara)

## Documentation
You'll find the Documentation [here](https://noahkamara.github.io/TelemachusKit/index.html
)
## 🤝 Contributing

Contributions, issues and feature requests are welcome!<br />Feel free to check [issues page](https://github.com/noahkamara/TelemachusKit/issues). 

## Recommended KSP and Telemachus Versions
Every Version of KSP that supports a Telemachus-Mod from the following list should be fine:
- [Telemachus by TeleIO](https://github.com/TeleIO/Telemachus-1)
If you've tried with other Versions, please create an Issue with tag (enhancement) containing the url to the mod and the KSP versions tested

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
        .Package(url: "https://github.com/noahkamara/TelemachusKit.git", majorVersion: 1)
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
let telemachus = TelemachusClient()
telemachus.onConnect = { 
  print("connected to \(telemachus.currentUrl)")
}
telemachus.connect("127.0.0.1", 8085) {
  telemachus.subscribeTo(TelemachusClient.ApiKey.allCases) // Subscribe to all values
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
