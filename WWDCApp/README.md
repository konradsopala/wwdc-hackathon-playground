# Hackathon Story - SwiftUI iOS App

A modern SwiftUI conversion of the WWDC 2018 Scholarship playground, bringing your hackathon story to life on iOS.

## ✨ Features

- 📖 **Story-book navigation**: Swipe between 5 animated story pages
- 🎙️ **Audio narration**: Each page narrates its story using AVFoundation
- ✨ **Rich animations**: Smooth SwiftUI animations throughout
- 🎨 **Modern design**: Built with iOS 17+ and latest SwiftUI features
- 📱 **Native iOS**: Runs on iPhone and iPad

## 🚀 Quick Start

### Option 1: Detailed Setup (Recommended)
Read [SETUP_INSTRUCTIONS.md](SETUP_INSTRUCTIONS.md) for step-by-step instructions.

### Option 2: Quick Setup

1. **Create new Xcode project**:
   - iOS App, SwiftUI, iOS 17.0 minimum
   - Name it "HackathonStory"

2. **Copy files**:
   ```bash
   # Copy all .swift files from WWDCApp/ to your Xcode project
   ```

3. **Copy assets**:
   ```bash
   # Run the helper script
   ./copy-assets.sh ~/path/to/YourProject/Assets.xcassets
   ```

4. **Build and run** 🎉

## 📁 Project Structure

```
WWDCApp/
├── WWDCAppApp.swift              # App entry point
├── ContentView.swift             # Page-based navigation
├── Helpers/
│   └── AudioNarrator.swift       # Audio narration helper
└── Views/
    ├── IntroView.swift          # Introduction
    ├── FirstDayView.swift       # Day 1: Arrival
    ├── SecondDayView.swift      # Day 2: Coding
    ├── FinalDayView.swift       # Final Day: Results
    └── LastView.swift           # Conclusion
```

## 📚 Documentation

- **[SETUP_INSTRUCTIONS.md](SETUP_INSTRUCTIONS.md)**: Complete setup guide
- **[CONVERSION_SUMMARY.md](CONVERSION_SUMMARY.md)**: What was converted and how
- **copy-assets.sh**: Helper script to copy images from playground

## 🎬 Story Pages

1. **Intro**: "Once upon a time..." - Meet the three scholarship hopefuls
2. **Day 1**: The team arrives at the hackathon with excitement
3. **Day 2**: Coding through day and night, helping each other
4. **Final Day**: Anxiously awaiting the WWDC results
5. **Last Page**: "To be continued..." - The journey continues

## 🛠 Technology Stack

- **Language**: Swift
- **Framework**: SwiftUI
- **Audio**: AVFoundation
- **Minimum iOS**: 17.0
- **Architecture**: Modern SwiftUI with @Observable pattern

## 🎨 Key SwiftUI Features Used

- TabView with page style for story-book navigation
- Declarative animations with `withAnimation()`
- Custom shapes and components
- Combine timers for countdown
- @Observable for state management
- Audio integration with lifecycle management

## 📝 Customization

### Change the countdown date
Edit `FinalDayView.swift`:
```swift
components.year = 2026  // Your year
components.month = 4    // Your month
components.day = 20     // Your day
```

### Modify narration text
Each view has a `narrator.speak()` call you can customize.

### Adjust animations
Look for `withAnimation()` blocks and `.animation()` modifiers.

## 🐛 Troubleshooting

**Images not showing?**
- Ensure all images are in Assets.xcassets
- Check image names match exactly (case-sensitive)

**No audio?**
- Check device volume
- Test on physical device (simulator audio can be unreliable)

**Build errors?**
- Ensure iOS 17.0+ deployment target
- Clean build folder (Shift+Cmd+K)

## 📄 License

This is a conversion of the original WWDC 2018 Scholarship playground. See the main repository LICENSE.md for details.

## 🙏 Credits

Original playground created for WWDC 2018 Scholarship.
Converted to modern SwiftUI in 2026.

---

**Ready to build?** Open Xcode and bring this hackathon story to life! 🚀
