# PrettyLogger

![Platform](https://img.shields.io/badge/platform-iOS-blue.svg?style=flat) 
![Platform](https://img.shields.io/badge/platform-tvOS-blue.svg?style=flat)
![Platform](https://img.shields.io/badge/platform-mac-blue.svg?style=flat)

## Introduction
A pretty set of log functions to print message in console using levels (Debug, Info, Trace, Warning & Error) and emojis to improve visibility 💪

## Platforms 
Support for iOS, tvOS and macOS

## Support
For Swift 4 please use v1

For Swift 5 please use v2+

## Installation
PrettyLogger is available through [Swift Package Manager](https://swift.org/package-manager/). 

1. Follow Apple's [Adding Package Dependencies to Your App](
https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app
) guide on how to add a Swift Package dependency.
2. Use `https://github.com/hyperdevs-team/PrettyLogger` as the repository URL.
3. Specify the version to be at least `3.0.0`.

## Usage
### Print messages
To print a message in the console you simply use any of the global functions:
```swift
  logWarning("This a warning!!")
  logError("This is showed as error")
  logFatal("This is showed as fatal message")
  logInfo("This is an info message")
  logDebug("This is a debug message")
  logTrace("This is a trace info")
```
The previous example will print: 
```ogdl 
13:31:59.632 ◉ ⚠️⚠️⚠️ This a warning!! [File.swift:L109]
13:31:59.639 ◉ ❌❌❌ This is showed as error [File.swift:L110]
13:31:59.639 ◉ ☠️☠️☠️ This is showed as fatal message [File.swift:L111]
13:31:59.639 ◉ 🔍 This is an info message [File.swift:L112]
13:31:59.639 ◉ 🐛 This is a debug message [File.swift:L113]
13:31:59.640 ◉ ✏️ This is a trace info [File.swift:L114]
```
### Level
You can silent all logs (or some, depending on level) by setting the property `level` on the shared instance:
```swift
PrettyLogger.shared.level = .all //To show all messages
PrettyLogger.shared.level = .disable //To silent logger
PrettyLogger.shared.level = .info //To show all message except debug & trace
```
The available levels, in order, are: disable, fatal, error, warn, info, debug, trace & all 
### Global framework
If you want to import all functions in your project without import PrettyLogger in every file you could use this directive in your AppDelegate: 
```swift
@_exported import PrettyLogger
```
