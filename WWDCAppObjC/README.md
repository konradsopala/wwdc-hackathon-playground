# Hackathon Story - Objective-C UIKit Version

An Objective-C UIKit conversion of the SwiftUI Hackathon Story app, bringing your hackathon story to life using classic iOS development patterns.

## ✨ Features

- 📖 **Page-based navigation**: Swipe between 5 story pages using UIPageViewController
- 🎙️ **Audio narration**: Text-to-speech using AVFoundation
- ✨ **UIKit animations**: Classic UIView animations
- 🎨 **Classic iOS design**: Built with Objective-C and UIKit
- 📱 **iOS 12.0+**: Supports older iOS versions

## 📁 Project Structure

```
WWDCAppObjC/
├── AppDelegate.h/m              # App lifecycle management
├── main.m                       # App entry point
├── Classes/
│   ├── Helpers/
│   │   ├── HKAudioNarrator.h   # Audio narration helper (header)
│   │   └── HKAudioNarrator.m   # Audio narration helper (implementation)
│   └── ViewControllers/
│       ├── HKStoryPageViewController.h/m   # Main page controller
│       └── HKIntroViewController.h/m       # Intro page (fully implemented)
└── Resources/                   # Images and assets
```

## 💻 Programmatic UI Approach

**This app uses 100% programmatic UI - no Storyboards or XIBs required!**

All views are created and laid out in code using:
- Auto Layout with `NSLayoutConstraint`
- Programmatic view hierarchy in `viewDidLoad`
- No Interface Builder dependencies

**Why Programmatic?**
- ✅ Better for version control (no XML merge conflicts)
- ✅ More explicit and easier to review
- ✅ Matches the pure-code nature of SwiftUI
- ✅ Educational value in understanding UIKit fundamentals

The provided `Info.plist.template` is pre-configured for this approach (no storyboard references).

## 🎬 Story Pages

1. **Intro** (✅ Fully Implemented) - "Once upon a time..." with animations
2. **Day 1** (📝 Placeholder) - The team arrives at the hackathon
3. **Day 2** (📝 Placeholder) - Coding through day and night
4. **Final Day** (📝 Placeholder) - Anxiously awaiting the WWDC results
5. **Last Page** (📝 Placeholder) - "To be continued..."

## 🚀 Setup Instructions

### 1. Create Xcode Project

1. Open Xcode
2. **File > New > Project**
3. Choose **iOS > App**
4. Configure:
   - **Product Name**: HackathonStoryObjC
   - **Language**: **Objective-C** (important!)
   - **User Interface**: **Storyboard** (we'll use programmatic UI)
   - **Minimum Deployment**: iOS 12.0

### 2. Add Source Files

1. In Xcode, select your project
2. Right-click on the project folder
3. **Add Files to "HackathonStoryObjC"...**
4. Add all files from `WWDCAppObjC/` folder:
   - `AppDelegate.h` and `AppDelegate.m` (replace existing)
   - `main.m` (replace existing)
   - All files from `Classes/` folder

### 3. Configure Project Settings

#### Info.plist Configuration

This app uses **fully programmatic UI** with no storyboards or XIBs.

**Option 1: Use the provided template (Recommended)**
1. Delete the default `Info.plist` in your Xcode project
2. Copy `Info.plist.template` to your project folder
3. Rename it to `Info.plist`
4. The template is already configured for programmatic UI (no launch screen)

**Option 2: Modify existing Info.plist**
1. Select your project target → **Info** tab
2. Remove **Main storyboard file base name** entry
3. Remove **Launch screen interface file base name** entry (if present)
4. Go to **Build Settings** → Search for "Main"
5. Clear **UIMainStoryboardFile** value

**Note:** The app launches directly from `AppDelegate` without storyboards. If you want to add a launch screen later, create `LaunchScreen.storyboard` and add `UILaunchStoryboardName` key to Info.plist.

#### Add Images
1. Open `Assets.xcassets`
2. Copy images from `Hackathon.playground/Pages/*/Resources/`
3. Required images:
   - KonradHead.png
   - YaoHead.png
   - BlakeHead.png

### 4. Build and Run

1. Select a simulator or device
2. Press **Cmd + R** or click the Play button
3. The app should launch showing the orange intro page

## 🛠 Key Classes

### HKAudioNarrator

A helper class for text-to-speech narration.

**Usage:**
```objective-c
HKAudioNarrator *narrator = [[HKAudioNarrator alloc] init];
[narrator speak:@"Hello, world!"];
[narrator stop]; // When done
```

**Features:**
- KVO-compliant `isSpeaking` property
- AVSpeechSynthesizerDelegate for proper state management
- Automatic cleanup on dealloc

### HKStoryPageViewController

Main container using UIPageViewController for page-based navigation.

**Features:**
- Swipe gesture navigation
- Page indicator dots
- Data source for 5 pages
- Manages view controller lifecycle

### HKIntroViewController

Fully implemented intro page with:
- Orange background
- Pulsing "Once upon a time..." text
- Character heads sliding in from left
- Audio narration on appear
- Proper cleanup on disappear

## 📝 Extending the App

### To Implement Additional Pages:

1. **Create View Controller Header:**
```objective-c
// HKFirstDayViewController.h
#import <UIKit/UIKit.h>

@interface HKFirstDayViewController : UIViewController
@end
```

2. **Create Implementation:**
```objective-c
// HKFirstDayViewController.m
#import "HKFirstDayViewController.h"
#import "HKAudioNarrator.h"

@interface HKFirstDayViewController ()
@property (nonatomic, strong) HKAudioNarrator *narrator;
@end

@implementation HKFirstDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Add your UI elements
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.narrator = [[HKAudioNarrator alloc] init];
    [self.narrator speak:@"Your narration text"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.narrator stop];
}

@end
```

3. **Add to Page Controller:**
```objective-c
// In HKStoryPageViewController.m, setupPages method:
#import "HKFirstDayViewController.h"

HKFirstDayViewController *firstDayVC = [[HKFirstDayViewController alloc] init];
// Replace the placeholder in self.pages array
```

## 🔧 Technical Details

### Memory Management
- Uses ARC (Automatic Reference Counting)
- Proper cleanup in `viewWillDisappear:`
- No retain cycles in audio narration

### Animations
- UIView block-based animations
- `UIViewAnimationOptionRepeat` for pulsing effects
- CGAffineTransform for position/scale changes

### Layout
- Programmatic Auto Layout with NSLayoutConstraint
- No Interface Builder / Storyboards
- Supports all device sizes

## 🆚 Differences from SwiftUI Version

| Feature | SwiftUI | Objective-C UIKit |
|---------|---------|-------------------|
| Language | Swift | Objective-C |
| UI Framework | SwiftUI | UIKit |
| Layout | Declarative | Programmatic Auto Layout |
| State Management | @State, @Observable | Properties + KVO |
| View Lifecycle | onAppear/onDisappear | viewDidAppear/viewWillDisappear |
| Animations | withAnimation() | UIView animate blocks |
| Navigation | TabView | UIPageViewController |
| Min iOS | 17.0 | 12.0 |

## 📊 Implementation Status

- ✅ **Complete**: HKAudioNarrator, HKStoryPageViewController, HKIntroViewController
- 📝 **Placeholder**: FirstDay, SecondDay, FinalDay, LastPage view controllers
- 🎯 **Ready to extend**: Follow the patterns in HKIntroViewController

## 🐛 Troubleshooting

**Build Errors:**
- Ensure all `.h` and `.m` files are added to the target
- Check that file names match import statements
- Verify minimum deployment target is set

**Launch Screen Warnings:**
- If Xcode warns about missing LaunchScreen.storyboard, that's expected
- This app uses programmatic UI without storyboards
- To suppress: Remove `UILaunchStoryboardName` from Info.plist (already done in template)
- To add one: Create LaunchScreen.storyboard via File > New > File > Launch Screen

**Black Screen on Launch:**
- Verify `AppDelegate.m` creates and shows the window
- Check that `application:didFinishLaunchingWithOptions:` returns YES
- Ensure Info.plist has no storyboard references

**Images Not Showing:**
- Check image names in Assets.xcassets match exactly
- Images must be added to the target

**No Audio:**
- Check device/simulator volume
- Test on physical device (simulator audio can be unreliable)
- Verify AVFoundation is linked

## 📚 Additional Resources

- [UIViewController Documentation](https://developer.apple.com/documentation/uikit/uiviewcontroller)
- [UIPageViewController Guide](https://developer.apple.com/documentation/uikit/uipageviewcontroller)
- [AVSpeechSynthesizer Reference](https://developer.apple.com/documentation/avfaudio/avspeechsynthesizer)

## 🎓 Learning Objectives

This Objective-C version demonstrates:
- **Classic iOS Development**: UIKit patterns and practices
- **MVC Architecture**: Clear separation of concerns
- **Memory Management**: ARC and proper cleanup
- **Programmatic UI**: Layout without Interface Builder
- **Animation Techniques**: UIView animation APIs
- **Delegation**: AVSpeechSynthesizerDelegate pattern

---

**Ready to build?** Open Xcode and experience the classic iOS development workflow! 🚀
