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

#### Remove Storyboard (Optional - for pure programmatic UI)
1. Select your project target
2. Go to **Info** tab
3. Remove **Main storyboard file base name** entry
4. Go to **Build Settings**
5. Search for "Main"
6. Clear **UIMainStoryboardFile** value

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
- [AVSpeechSynthesizer Reference](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizer)

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
