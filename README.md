# Hackathon Playground

<a href="https://en.wikipedia.org/wiki/Apple_Worldwide_Developers_Conference"><img src="https://img.shields.io/badge/WWDC-2018-BLUEVIOLET" alt=""/></a>  <a href="https://developer.apple.com/videos/wwdc2018/"><img src="https://img.shields.io/badge/Scholarship-Submission-BLUEVIOLET" alt=""/></a>  <a href="https://www.apple.com/swift/playgrounds/"><img src="https://img.shields.io/badge/Swift-Playgrounds-blueviolet" alt=""/></a>

![](/Assets/introImageOne.png)

Hackathon Playground is my WWDC 2018 Scholarship app. The main theme of the app are hackathons in general. The aim of this project was to create a playground that would tell a compelling story and showcase some of the functionalities that Swift provides to Apple Developers.

## Swift Package

This project has been converted to a modern Swift Package with SwiftUI, supporting iOS 17+ and macOS 14+.

### Swift Version

* <a href="https://developer.apple.com/swift/"><img src="https://img.shields.io/badge/Swift-5.9-green.svg" alt="swift version"/></a>

### Frameworks Used

* [SwiftUI](https://developer.apple.com/xcode/swiftui/) - Modern declarative UI framework
* [AVFoundation](https://developer.apple.com/av-foundation/) - Speech synthesis for storytelling
* [Foundation](https://developer.apple.com/documentation/foundation)

### Project Structure

```
Sources/HackathonPlayground/
├── HackathonPlaygroundApp.swift  # App entry point
├── ContentView.swift              # Main navigation
└── Views/
    ├── IntroPageView.swift        # "Once upon a time..."
    ├── FirstDayPageView.swift     # Arrival at hackathon
    ├── SecondDayPageView.swift    # Coding session
    ├── FinalDayPageView.swift     # Results countdown
    └── LastPageView.swift         # "To be continued..."
```

### Building

```bash
# Build the package
swift build

# Run tests
swift test
```

### Legacy Playground

The original UIKit-based Swift Playground is preserved in the `Hackathon.playground` directory.

### Screenplay

![](/Assets/HackathonPlaygroundGif.gif)
