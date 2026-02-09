# Hackathon Story - SwiftUI iOS App Setup Instructions

This document explains how to set up and run your converted SwiftUI iOS app from the original Xcode Playground.

## Project Overview

This is a modern SwiftUI conversion of the WWDC 2018 Scholarship playground, featuring:
- 📱 Page-based navigation (swipe between story pages)
- 🎙️ Audio narration using AVFoundation
- ✨ Smooth animations and transitions
- 🎨 iOS 17+ modern SwiftUI features

## Setup Steps

### 1. Create a New Xcode Project

1. Open **Xcode**
2. Select **File > New > Project**
3. Choose **iOS > App**
4. Configure your project:
   - **Product Name**: `HackathonStory`
   - **Interface**: SwiftUI
   - **Language**: Swift
   - **Minimum Deployment**: iOS 17.0
5. Choose a location to save (can be this folder)

### 2. Add the SwiftUI Files

Copy all the Swift files from the `WWDCApp` folder into your new Xcode project:

**Main Files:**
- `WWDCAppApp.swift` → Rename to `HackathonStoryApp.swift` and update the struct name
- `ContentView.swift`

**Views Folder:**
- `Views/IntroView.swift`
- `Views/FirstDayView.swift`
- `Views/SecondDayView.swift`
- `Views/FinalDayView.swift`
- `Views/LastView.swift`

**Helpers Folder:**
- `Helpers/AudioNarrator.swift`

### 3. Set Up Assets

You need to copy all images from the playground's Resources folders to your Xcode project's Asset Catalog:

**Required Images:**

From `Hackathon.playground/Pages/IntroPage.xcplaygroundpage/Resources/`:
- KonradHead.png
- YaoHead.png
- BlakeHead.png

From `Hackathon.playground/Pages/FirstDayPage.xcplaygroundpage/Resources/`:
- HackathonVenue.png
- KonradMini.png
- BlakeMini.png
- YaoMini.png
- Sun.png

From `Hackathon.playground/Pages/SecondDayPage.xcplaygroundpage/Resources/`:
- ImacWithPlaygrounds.png
- DarkBird.png
- AppleMoon.png
- Sun.png
- BlakeBack.png
- KonradBack.png
- YaoBack.png

From `Hackathon.playground/Pages/FinalDayPage.xcplaygroundpage/Resources/`:
- Konrad.png
- Blake.png
- Yao.png
- Sweat.png
- Timer.png

From `Hackathon.playground/Pages/LastPage.xcplaygroundpage/Resources/`:
- Same head images as IntroPage

**To add images to Assets:**
1. Open your Xcode project
2. Select `Assets.xcassets` in the navigator
3. Drag and drop each image file into the asset catalog
4. Make sure each image name matches the names used in the code

### 4. Configure Info.plist for Audio

Since the app uses AVFoundation for audio narration, you may need to add privacy descriptions:

1. Open your project's `Info.plist`
2. Add the following if needed for audio:
   - **Privacy - Microphone Usage Description** (if using microphone): "This app uses text-to-speech for narration"

### 5. Build and Run

1. Select a simulator or device (iOS 17.0+)
2. Press **Cmd + R** or click the Play button
3. The app should build and run successfully

## Features

### Page Navigation
- **Swipe left/right** to navigate between story pages
- **Tap chevron buttons** at the bottom for precise navigation
- **Page dots** at the bottom show current position

### Story Pages

1. **Intro**: Orange background with animated title and character heads
2. **Day 1**: Characters arriving at the hackathon venue with speech bubbles
3. **Day 2**: Coding scene with day/night transition and animations
4. **Final Day**: Countdown timer to results announcement with anxiety animations
5. **Last Page**: "To be continued..." with rotating character faces

### Audio Narration
- Each page has its own narration that plays automatically when the page appears
- Audio stops automatically when you navigate away from a page

## Customization

### Updating the Countdown Date
In `FinalDayView.swift`, update the target date:
```swift
let targetDate: Date = {
    var components = DateComponents()
    components.year = 2026  // Update this
    components.month = 4
    components.day = 20
    components.hour = 8
    components.minute = 0
    return Calendar.current.date(from: components) ?? Date()
}()
```

### Adjusting Animations
All animations use SwiftUI's declarative animation system. Look for:
- `withAnimation()` blocks
- `.animation()` modifiers
- `@State` properties that trigger animations

### Customizing Audio
The `AudioNarrator` helper class handles all speech synthesis. You can:
- Modify the text in each view's `narrator.speak()` call
- Change the voice language (default: "en-US")
- Adjust speech rate

## Troubleshooting

### Images Not Showing
- Verify all image names in Assets.xcassets match exactly (case-sensitive)
- Check that images are added to the correct target

### Audio Not Playing
- Check device/simulator volume
- Verify AVFoundation is imported in files that use AudioNarrator
- Test on a physical device if simulator audio is problematic

### Build Errors
- Ensure deployment target is iOS 17.0 or higher
- Check that all files are added to the target
- Clean build folder: **Product > Clean Build Folder** (Shift + Cmd + K)

## Next Steps

Consider enhancing the app with:
- Custom fonts matching the original Avenir-Heavy style
- More sophisticated animations
- Interactive elements on each page
- Sharing functionality to share your hackathon story
- Dark mode support
- iPad optimization

Enjoy your SwiftUI hackathon story app! 🎉
